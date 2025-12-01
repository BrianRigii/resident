import 'package:resident/core/utils/phone_number.dart';

class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final PhoneNumber? phoneNumber;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.phoneNumber,
  });
}
