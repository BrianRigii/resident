import 'dart:async';
import 'dart:developer';

import 'package:resident/core/utils/entity_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents the freshness state of cached data
enum DataFreshness {
  /// Data was recently fetched and is still considered fresh
  fresh,

  /// Data is slightly outdated but still usable
  stale,

  /// Data is outdated and should be refreshed
  expired,
}

/// Configuration for how data caching behaves over time
class CacheConfig {
  /// Duration after which cached data is considered stale
  final Duration staleThreshold;

  /// Duration after which cached data is considered expired
  final Duration expiredThreshold;

  /// Whether to automatically fetch fresh data in the background
  final bool enableBackgroundSync;

  /// Creates a new cache configuration
  const CacheConfig({
    this.staleThreshold = const Duration(minutes: 5),
    this.expiredThreshold = const Duration(hours: 1),
    this.enableBackgroundSync = true,
  });

  /// Configuration for data that changes frequently (e.g. chat, notifications)
  static const CacheConfig realTime = CacheConfig(
    staleThreshold: Duration(seconds: 30),
    expiredThreshold: Duration(minutes: 5),
  );

  /// Configuration for data that changes occasionally (e.g. budgets, accounts)
  static const CacheConfig moderate = CacheConfig(
    staleThreshold: Duration(minutes: 15),
    expiredThreshold: Duration(hours: 6),
  );

  /// Configuration for data that rarely changes (e.g. settings, profile)
  static const CacheConfig stable = CacheConfig(
    staleThreshold: Duration(hours: 1),
    expiredThreshold: Duration(days: 1),
  );
}

class KeepAliveConfig {
  /// How long to keep the provider alive before auto-disposing
  final Duration keepAliveThreshold;

  /// Creates a new keep-alive configuration
  const KeepAliveConfig({this.keepAliveThreshold = const Duration(minutes: 5)});

  static const KeepAliveConfig stable = KeepAliveConfig(
    keepAliveThreshold: Duration(minutes: 5),
  );

  static const KeepAliveConfig realTime = KeepAliveConfig(
    keepAliveThreshold: Duration(seconds: 30),
  );

  static const KeepAliveConfig moderate = KeepAliveConfig(
    keepAliveThreshold: Duration(minutes: 15),
  );
}

/// A generic caching strategy class for handling local and remote data sources.
/// Implemented by repositories to manage data freshness, caching, and sync.
abstract class FetchStrategy<T> {
  final CacheConfig cacheConfig;
  final EntityKey entityKey;
  final SharedPreferences _prefs;

  DateTime? _lastFetch;
  bool _isInitialized = false;

  /// Creates a new fetch strategy with the given cache configuration and entity key.
  ///
  /// [entityKey] should be a unique identifier for this data type (e.g., 'transactions', 'budgets', 'accounts').
  /// This key is used to persist the last fetch timestamp in SharedPreferences.

  FetchStrategy({
    required this.entityKey,
    required SharedPreferences prefs,
    this.cacheConfig = const CacheConfig(),
  }) : _prefs = prefs;

  // Abstract methods to be implemented by child repositories

  /// Fetch data from the local source
  Future<List<T>> fetchFromLocal();

  /// Fetch data from the remote source (e.g. REST, Supabase)
  Future<List<T>> fetchFromRemote();

  /// Update the local cache with fresh data usually after a remote fetch.
  Future<void> updateLocalCache(List<T> items);

  // Private methods for persistence

  /// SharedPreferences key for storing the last fetch timestamp
  String get _lastFetchKey => 'fetch_strategy_last_fetch_$entityKey';

  /// Initialize the fetch strategy by loading the last fetch timestamp from SharedPreferences
  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;

    try {
      final lastFetchString = _prefs.getString(_lastFetchKey);

      if (lastFetchString != null) {
        _lastFetch = DateTime.parse(lastFetchString);
      }
    } catch (e) {
      log('Failed to load last fetch timestamp for $entityKey: $e');
      // Continue with null _lastFetch if loading fails
    }

    _isInitialized = true;
  }

  /// Persist the last fetch timestamp to SharedPreferences
  Future<void> _persistLastFetch(DateTime dateTime) async {
    _lastFetch = dateTime;

    try {
      await _prefs.setString(_lastFetchKey, dateTime.toIso8601String());
    } catch (e) {
      log('Failed to persist last fetch timestamp for $entityKey: $e');
      // Continue with in-memory timestamp if persistence fails
    }
  }

  /// Main method to retrieve data using smart caching strategies.
  ///
  /// - `forceRefresh`: forces a remote call.
  /// - `isUserInitiated`: e.g. user pulled to refresh.
  Future<List<T>> getAll({
    bool forceRefresh = false,
    bool userInitiated = false,
  }) async {
    await _ensureInitialized();

    final freshness = _getDataFreshness();

    // Use aggressive refresh if user explicitly triggered
    if (forceRefresh || userInitiated) {
      return await _networkFirstStrategy();
    }

    switch (freshness) {
      case DataFreshness.fresh:
        return await _cacheOnlyStrategy();

      case DataFreshness.stale:
        return await _cacheThenNetworkStrategy();

      case DataFreshness.expired:
        return await _networkFirstStrategy();
    }
  }

  /// Internal: Determine freshness of currently cached data.
  DataFreshness _getDataFreshness() {
    if (_lastFetch == null) return DataFreshness.expired;

    final timeSinceLastFetch = DateTime.now().difference(_lastFetch!);

    if (timeSinceLastFetch < cacheConfig.staleThreshold) {
      return DataFreshness.fresh;
    } else if (timeSinceLastFetch < cacheConfig.expiredThreshold) {
      return DataFreshness.stale;
    } else {
      return DataFreshness.expired;
    }
  }

  /// Strategy that returns only local cache.
  Future<List<T>> _cacheOnlyStrategy() async {
    return await fetchFromLocal();
  }

  /// Strategy that shows cached data immediately and updates in background.
  Future<List<T>> _cacheThenNetworkStrategy() async {
    final localItems = await fetchFromLocal();

    if (cacheConfig.enableBackgroundSync) {
      // Fire and forget background update
      unawaited(_updateFromNetworkInBackground());
    }

    return localItems;
  }

  /// Strategy that fetches from the network first, falling back to cache on failure.
  Future<List<T>> _networkFirstStrategy() async {
    try {
      final remoteItems = await fetchFromRemote();
      await updateLocalCache(remoteItems);
      await _persistLastFetch(DateTime.now());
      return remoteItems;
    } catch (e) {
      log('Network fetch failed, falling back to cache - $e');
      return await fetchFromLocal();
    }
  }

  /// Background updater for syncing remote data silently
  Future<void> _updateFromNetworkInBackground() async {
    try {
      final remoteItems = await fetchFromRemote();
      await updateLocalCache(remoteItems);
      await _persistLastFetch(DateTime.now());
    } catch (e) {
      log('Background sync failed - $e');
    }
  }

  /// Manually triggers a full refresh from the network
  Future<List<T>> refresh() async {
    return await getAll(forceRefresh: true);
  }

  // Freshness status helpers

  bool get isFresh => _getDataFreshness() == DataFreshness.fresh;
  bool get isStale => _getDataFreshness() == DataFreshness.stale;
  bool get isExpired => _getDataFreshness() == DataFreshness.expired;

  /// Returns how long it’s been since the last fetch
  Duration? get timeSinceLastFetch =>
      _lastFetch != null ? DateTime.now().difference(_lastFetch!) : null;

  /// Set the last fetch time manually (e.g. for testing or mocking)
  Future<void> setLastFetch(DateTime dateTime) async {
    await _persistLastFetch(dateTime);
  }

  /// Invalidates the current cache so that data is treated as expired
  Future<void> invalidateCache() async {
    _lastFetch = null;

    try {
      await _prefs.remove(_lastFetchKey);
    } catch (e) {
      log('Failed to clear persisted last fetch timestamp for $entityKey: $e');
    }
  }
}
