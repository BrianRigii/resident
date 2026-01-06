@GenerateAdapters([AdapterSpec<User>(), AdapterSpec<PhoneNumber>()])
library;

import 'package:hive_ce/hive.dart';
import 'package:resident/core/utils/phone_number.dart';
import 'package:resident/features/auth/models/user.dart';

part 'hive_adapters.g.dart';
