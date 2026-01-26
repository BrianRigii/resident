import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:resident/features/properties/domain/property_service.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/presentation/property_state.dart';

class PropertyNotifier extends ChangeNotifier {
  final PropertyService propertyService;

  PropertyState _state = PropertyStateIdle();
  PropertyState get state => _state;

  set state(PropertyState val) {
    _state = val;
    notifyListeners();
  }

  bool _isGettingProperties = false;
  bool get isGettingProperties => _isGettingProperties;

  set isGettingProperties(bool val) {
    _isGettingProperties = val;
    notifyListeners();
  }

  List<Property> properties = [];

  PropertyNotifier({required this.propertyService});

  Future<void> addProperty(Map<String, dynamic> data) async {
    try {
      state = PropertyStateLoading();
      await propertyService.addProperty(data);
      await propertyService.invalidateCache();
    } catch (e) {
      state = PropertyStateError(e.toString());
    }
  }

  void resetPropertyState() {
    state = PropertyStateIdle();
    notifyListeners();
  }

  Future<void> fetchProperties({
    bool forceRefresh = false,
    bool userInitiated = false,
  }) async {
    isGettingProperties = true;
    notifyListeners();

    try {
      final items = await propertyService.getProperties(
        forceRefresh: forceRefresh,
        userInitiated: userInitiated,
      );
      properties.clear();
      properties = [...items];
    } catch (e) {
      state = PropertyStateError(e.toString());
      isGettingProperties = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    log('Disposing PropertyNotifier');
  }
}
