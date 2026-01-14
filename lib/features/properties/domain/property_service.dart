import 'package:resident/core/utils/entity_key.dart';
import 'package:resident/core/utils/fetch_strategy.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/sources/property_local_source.dart';
import 'package:resident/features/properties/sources/property_remote_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

const EntityKey propertiesKey = EntityKey('properties');

abstract class PropertyService {
  Future<List<Property>> getProperties({
    bool forceRefresh = false,
    bool userInitiated = false,
  });
  Future<Property> getPropertyById(String id);
  Future<void> addProperty(Map<String, dynamic> data);
  Future<void> editProperty(String id, Map<String, dynamic> data);
  Future<void> removeProperty(String id);
  Future<void> invalidateCache();
}

class PropertyServiceImpl extends FetchStrategy<Property>
    implements PropertyService {
  final PropertyRemoteSource propertyRemoteSource;
  final PropertyLocalSource propertyLocalSource;
  final SharedPreferences prefs;

  PropertyServiceImpl(
    this.propertyRemoteSource,
    this.propertyLocalSource,
    this.prefs,
  ) : super(
        entityKey: propertiesKey,
        prefs: prefs,
        cacheConfig: CacheConfig.realTime,
      );

  @override
  Future<List<Property>> getProperties({
    bool forceRefresh = false,
    bool userInitiated = false,
  }) async {
    return getAll(forceRefresh: forceRefresh, userInitiated: userInitiated);
  }

  @override
  Future<Property> getPropertyById(String id) async {
    return await propertyRemoteSource.fetchPropertyById(id);
  }

  @override
  Future<void> addProperty(Map<String, dynamic> data) async {
    await propertyLocalSource.createProperty(data);
    await propertyRemoteSource.createProperty(data);
  }

  @override
  Future<void> editProperty(String id, Map<String, dynamic> data) async {
    await propertyRemoteSource.updateProperty(id, data);
    await propertyLocalSource.updateProperty(id, data);
  }

  @override
  Future<void> removeProperty(String id) async {
    await propertyRemoteSource.deleteProperty(id);
    await propertyLocalSource.deleteProperty(id);
  }

  @override
  Future<void> invalidateCache() async {
    await super.invalidateCache();
  }

  @override
  Future<List<Property>> fetchFromLocal() =>
      propertyLocalSource.fetchProperties();

  @override
  Future<List<Property>> fetchFromRemote() =>
      propertyRemoteSource.fetchProperties();

  @override
  Future<void> updateLocalCache(List<Property> items) async {
    await propertyLocalSource.clearProperties();
    await propertyLocalSource.cacheProperties(items);
  }
}
