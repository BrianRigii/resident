@GenerateAdapters([
  AdapterSpec<User>(),
  AdapterSpec<PhoneNumber>(),
  AdapterSpec<Property>(),
  AdapterSpec<Unit>(),
])
library;

import 'package:hive_ce/hive.dart';
import 'package:resident/core/utils/phone_number.dart';
import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/units/models/unit.dart';

part 'hive_adapters.g.dart';
