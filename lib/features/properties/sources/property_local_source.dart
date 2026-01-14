import 'package:hive_ce_flutter/adapters.dart';
import 'package:resident/features/properties/models/property.dart';

abstract class PropertyLocalSource {
  Future<List<Property>> fetchProperties();
  Future<Property> fetchPropertyById(String id);
  Future<Property> createProperty(Map<String, dynamic> data);
  Future<void> updateProperty(String id, Map<String, dynamic> data);
  Future<void> deleteProperty(String id);
  Future<void> clearProperties();
  Future<List<Property>> cacheProperties(List<Property> properties);
}

class PropertyLocalSourceImpl extends PropertyLocalSource {
  Box<Property> propertyBox;
  PropertyLocalSourceImpl(this.propertyBox);
  @override
  Future<Property> createProperty(Map<String, dynamic> data) async {
    Property property = Property(
      id: data['id'],
      name: data['name'],
      landLordId: data['landlord_id'] ?? [],
      address: data['address'],
    );

    await propertyBox.put(property.id, property);
    return property;
  }

  @override
  Future<void> deleteProperty(String id) {
    return propertyBox.delete(id);
  }

  @override
  Future<List<Property>> fetchProperties() async {
    return propertyBox.values.toList(growable: false);
  }

  @override
  Future<Property> fetchPropertyById(String id) async {
    final property = propertyBox.get(id);
    if (property == null) {
      throw StateError('Property with id $id not found in local cache');
    }
    return property;
  }

  @override
  Future<void> updateProperty(String id, Map<String, dynamic> data) async {
    final existing = propertyBox.get(id);
    if (existing == null) {
      throw StateError('Cannot update missing property with id $id');
    }

    final updated = Property(
      id: existing.id,
      name: (data['name'] ?? existing.name) as String,
      address: (data['address'] ?? existing.address) as String,
      landLordId:
          (data['landlord_id'] ?? data['landLordId'] ?? existing.landLordId)
              as List<String>,
      isActive: (data['isActive'] ?? existing.isActive) as bool,
    );

    await propertyBox.put(id, updated);
  }

  @override
  Future<List<Property>> cacheProperties(List<Property> properties) async {
    for (var property in properties) {
      await propertyBox.put(property.id, property);
    }
    return properties;
  }

  @override
  Future<void> clearProperties() async {
    await propertyBox.clear();
  }
}
