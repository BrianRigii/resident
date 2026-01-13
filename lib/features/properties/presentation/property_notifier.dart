import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/domain/property_service.dart';

class PropertyNotifier extends ChangeNotifier {
  final Future<PropertyService> propertyService;
  bool _isAddingProperty = false;

  PropertyNotifier({required this.propertyService});

  bool get isAddingProperty => _isAddingProperty;

  set isAddingProperty(bool val) {
    _isAddingProperty = val;
    notifyListeners();
  }

  List<Property> properties = [];

  void addProperty(Map<String, dynamic> data) async {
    PropertyService service = await propertyService;
    await service.addProperty(data);
    notifyListeners();
  }

  Future fetchProperties() async {
    PropertyService service = await propertyService;
    properties.addAll(await service.getProperties());
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    log('Disposing PropertyNotifier');
  }
}
