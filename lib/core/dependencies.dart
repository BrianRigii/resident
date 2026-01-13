import 'package:get_it/get_it.dart';

import 'package:resident/core/supabase/supabase.dart';

import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/sources/auth_local_source.dart';
import 'package:resident/features/auth/sources/auth_remote_source.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:resident/features/properties/sources/property_remote_source.dart';
import 'package:resident/features/properties/domain/property_service.dart';
import 'package:resident/features/units/data/unit_remote_source.dart';
import 'package:resident/features/units/domain/unit_service.dart';
import 'package:resident/hive/hive_registrar.g.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SupabaseService>(() => SupabaseService.create());

  await Hive.initFlutter();

  Hive.registerAdapters();

  getIt.registerSingletonAsync<Box<User>>(() => Hive.openBox<User>('user_box'));

  getIt.registerSingletonAsync<AuthLocalSource>(() async {
    final box = await getIt.getAsync<Box<User>>();
    return AuthLocalSourceImpl(box);
  });
  getIt.registerSingletonAsync<AuthRemoteSource>(() async {
    final supabase = await getIt.getAsync<SupabaseService>();
    return AuthRemoteSourceImpl(supabase.client);
  });

  getIt.registerLazySingletonAsync<PropertyRemoteSource>(() async {
    final supabase = await getIt.getAsync<SupabaseService>();
    return PropertyRemoteSourceImpl(supabase.client);
  });

  getIt.registerLazySingletonAsync<PropertyService>(() async {
    return PropertyServiceImpl(await getIt.getAsync<PropertyRemoteSource>());
  });

  getIt.registerSingletonAsync<UnitRemoteSource>(() async {
    final supabase = await getIt.getAsync<SupabaseService>();
    return UnitRemoteSourceImpl(supabase.client);
  });

  getIt.registerSingletonAsync<UnitService>(() async {
    return UnitServiceImpl(await getIt.getAsync<UnitRemoteSource>());
  });

  await getIt.allReady();
}
