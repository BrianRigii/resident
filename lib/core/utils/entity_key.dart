/// A simple, type-safe identifier for cached entities.
///
/// Prefer `EntityKey` over raw strings when configuring repositories so
/// keys are consistent and refactor-friendly. The string value is used when
/// persisting cache metadata (e.g., last fetch timestamps).
class EntityKey {
  /// The underlying string value of the key.
  final String value;

  /// Creates a new entity key with the given [value].
  const EntityKey(this.value);

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EntityKey && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
