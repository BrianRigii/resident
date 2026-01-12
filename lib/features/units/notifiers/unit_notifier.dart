import 'package:flutter/material.dart';
import 'package:resident/features/units/domain/unit_service.dart';

class UnitNotifier extends ChangeNotifier {
  final UnitService unitService;
  UnitNotifier({required this.unitService});
  Future<void> fetchUnits() async {
    notifyListeners();
  }

  Future<void> addUnit(Map<String, dynamic> data) async {
    await unitService.addUnit(data);
    notifyListeners();
  }
}
