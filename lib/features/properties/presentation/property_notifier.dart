import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resident/features/properties/property_service.dart';

class PropertyNotifier extends ChangeNotifier {
  final Future<PropertyService> propertyService;
  bool _isAddingProperty = false;

  PropertyNotifier({required this.propertyService});

  bool get isAddingProperty => _isAddingProperty;

  set isAddingProperty(bool val) {
    _isAddingProperty = val;
    notifyListeners();
  }

  void addProperty(Map<String, dynamic> data) async {
    PropertyService service = await propertyService;
    await service.addProperty(data);
    notifyListeners();
  }

  Future fetchProperties() async {
    PropertyService service = await propertyService;
    await service.getProperties();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    log('Disposing PropertyNotifier');
  }
}
