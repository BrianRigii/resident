import 'package:resident/core/utils/phone_number.dart';

class Tenant {
  final String id;
  final String name;
  final double deposit;
  final PhoneNumber phoneNumber;
  final String emailAddress;
  final DateTime? moveInDate;
  final String? unitId;
  final String? propertyId;

  Tenant({
    required this.id,
    required this.name,
    required this.deposit,
    required this.phoneNumber,
    required this.emailAddress,
    this.moveInDate,
    this.unitId,
    this.propertyId,
  });
}
