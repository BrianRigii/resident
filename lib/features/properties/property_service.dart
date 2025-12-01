import 'package:flutter/material.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/propert_api.dart';

abstract class PropertyService extends ChangeNotifier {
  bool isFetchingProperties = false;
  Future<List<Property>> getProperties();
  Future<Property> getPropertyById(String id);
  Future<void> addProperty(Map<String, dynamic> data);
  Future<void> editProperty(String id, Map<String, dynamic> data);
  Future<void> removeProperty(String id);
}

class PropertyServiceImpl extends PropertyService {
  final PropertApi propertApi;
  PropertyServiceImpl(this.propertApi);

  bool _isFetchingProperties = false;
  @override
  bool get isFetchingProperties => _isFetchingProperties;

  @override
  set isFetchingProperties(bool val) {
    _isFetchingProperties = val;
    notifyListeners();
  }

  @override
  Future<List<Property>> getProperties() async {
    try {
      isFetchingProperties = true;
      List<Property> properties = await propertApi.fetchProperties();
      isFetchingProperties = false;
      return properties;
    } catch (e) {
      isFetchingProperties = false;
      rethrow;
    }
  }

  @override
  Future<Property> getPropertyById(String id) async {
    return await propertApi.fetchPropertyById(id);
  }

  @override
  Future<void> addProperty(Map<String, dynamic> data) async {
    await propertApi.createProperty(data);
  }

  @override
  Future<void> editProperty(String id, Map<String, dynamic> data) async {
    await propertApi.updateProperty(id, data);
  }

  @override
  Future<void> removeProperty(String id) async {
    await propertApi.deleteProperty(id);
  }
}
