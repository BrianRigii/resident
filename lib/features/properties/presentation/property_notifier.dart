import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/domain/property_service.dart';

class PropertyNotifier extends ChangeNotifier {
  final PropertyService propertyService;
  bool _isAddingProperty = false;
  bool _isLoading = false;
  String? _error;

  PropertyNotifier({required this.propertyService});

  bool get isAddingProperty => _isAddingProperty;
  bool get isLoading => _isLoading;
  String? get error => _error;

  set isAddingProperty(bool val) {
    _isAddingProperty = val;
    notifyListeners();
  }

  List<Property> properties = [];

  Future<void> addProperty(Map<String, dynamic> data) async {
    isAddingProperty = true;
    _error = null;
    try {
      await propertyService.addProperty(data);
      await propertyService.invalidateCache();
      await fetchProperties(
        forceRefresh: true,
        userInitiated: true,
        replace: true,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      isAddingProperty = false;
    }
  }

  Future<void> fetchProperties({
    bool forceRefresh = false,
    bool userInitiated = false,
    bool replace = true,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final items = await propertyService.getProperties(
        forceRefresh: forceRefresh,
        userInitiated: userInitiated,
      );
      if (replace) {
        properties = items;
      } else {
        properties.addAll(items);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    log('Disposing PropertyNotifier');
  }
}
