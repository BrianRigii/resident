import 'package:get_it/get_it.dart';

import 'package:resident/core/supabase/supabase.dart';
import 'package:resident/features/auth/domain/auth_service.dart';

import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/sources/auth_local_source.dart';
import 'package:resident/features/auth/sources/auth_remote_source.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/sources/property_local_source.dart';
import 'package:resident/features/properties/sources/property_remote_source.dart';
import 'package:resident/features/properties/domain/property_service.dart';
import 'package:resident/features/units/data/unit_remote_source.dart';
import 'package:resident/features/units/domain/unit_service.dart';
import 'package:resident/hive/hive_registrar.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SupabaseService>(() => SupabaseService.create());
  getIt.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await _setupHive();

  getIt.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(
      getIt.get<AuthRemoteSource>(),
      getIt.get<AuthLocalSource>(),
    ),
  );

  getIt.registerLazySingleton<AuthLocalSource>(() {
    return AuthLocalSourceImpl(getIt.get<Box<User>>());
  });

  getIt.registerLazySingleton<AuthRemoteSource>(() {
    return AuthRemoteSourceImpl(getIt.get<SupabaseService>().client);
  });

  getIt.registerLazySingleton<PropertyRemoteSource>(() {
    return PropertyRemoteSourceImpl(getIt.get<SupabaseService>().client);
  });

  getIt.registerLazySingleton<PropertyService>(() {
    return PropertyServiceImpl(
      getIt.get<PropertyRemoteSource>(),
      getIt.get<PropertyLocalSource>(),
      getIt.get<SharedPreferences>(),
    );
  });

  getIt.registerLazySingleton<PropertyLocalSource>(() {
    return PropertyLocalSourceImpl(getIt.get<Box<Property>>());
  });

  getIt.registerLazySingleton<UnitRemoteSource>(() {
    return UnitRemoteSourceImpl(getIt.get<SupabaseService>().client);
  });

  getIt.registerLazySingleton<UnitService>(() {
    return UnitServiceImpl(getIt.get<UnitRemoteSource>());
  });

  await getIt.allReady();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();

  Hive.registerAdapters();

  getIt.registerSingletonAsync<Box<User>>(() => Hive.openBox<User>('user_box'));
  getIt.registerSingletonAsync<Box<Property>>(
    (() => Hive.openBox<Property>('property_box')),
  );
}
