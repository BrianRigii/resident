import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/sources/property_remote_source.dart';

abstract class PropertyService {
  Future<List<Property>> getProperties();
  Future<Property> getPropertyById(String id);
  Future<void> addProperty(Map<String, dynamic> data);
  Future<void> editProperty(String id, Map<String, dynamic> data);
  Future<void> removeProperty(String id);
}

class PropertyServiceImpl extends PropertyService {
  final PropertyRemoteSource propertyRemoteSource;
  PropertyServiceImpl(this.propertyRemoteSource);

  @override
  Future<List<Property>> getProperties() async {
    try {
      List<Property> properties = await propertyRemoteSource.fetchProperties();

      return properties;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Property> getPropertyById(String id) async {
    return await propertyRemoteSource.fetchPropertyById(id);
  }

  @override
  Future<void> addProperty(Map<String, dynamic> data) async {
    await propertyRemoteSource.createProperty(data);
  }

  @override
  Future<void> editProperty(String id, Map<String, dynamic> data) async {
    await propertyRemoteSource.updateProperty(id, data);
  }

  @override
  Future<void> removeProperty(String id) async {
    await propertyRemoteSource.deleteProperty(id);
  }
}
