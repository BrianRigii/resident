import 'package:resident/core/widgets/progress_stepper.dart';
import 'package:resident/features/units/models/unit.dart';

class AddPropertyNotifier extends StepperNotifier {
  bool _isLandLord = false;
  bool get isLandLord => _isLandLord;

  set isLandLord(bool val) {
    _isLandLord = val;
    notifyListeners();
  }

  String? propertyId;

  List<Unit> units = [];

  void addUnit(Map<String, dynamic> unitFormData) {
    notifyListeners();
  }

  void removeUnit(String unitId) {
    units.removeWhere((unit) => unit.id == unitId);
    notifyListeners();
  }
}
