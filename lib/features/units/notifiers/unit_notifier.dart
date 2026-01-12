import 'package:flutter/material.dart';

class UnitNotifier extends ChangeNotifier {
  Future<void> fetchUnits() async {
    notifyListeners();
  }
}
