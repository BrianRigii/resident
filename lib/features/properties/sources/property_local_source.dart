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
    // TODO: implement deleteProperty
    throw UnimplementedError();
  }

  @override
  Future<List<Property>> fetchProperties() {
    // TODO: implement fetchProperties
    throw UnimplementedError();
  }

  @override
  Future<Property> fetchPropertyById(String id) {
    // TODO: implement fetchPropertyById
    throw UnimplementedError();
  }

  @override
  Future<void> updateProperty(String id, Map<String, dynamic> data) {
    // TODO: implement updateProperty
    throw UnimplementedError();
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
