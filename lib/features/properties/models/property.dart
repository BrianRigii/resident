import 'package:resident/features/units/models/unit.dart';

class Property {
  final String id;
  final String name;
  final String address;
  final List<Unit> units;

  Property({
    required this.id,
    required this.name,
    required this.address,
    required this.units,
  });
}
