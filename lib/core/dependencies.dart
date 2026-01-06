import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:resident/core/supabase/supabase.dart';

import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/sources/auth_local_source.dart';
import 'package:resident/features/auth/sources/auth_remote_source.dart';
import 'package:resident/hive/hive_registrar.g.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SupabaseService>(() => SupabaseService.create());

  Hive
    ..init('')
    ..registerAdapters();

  getIt.registerSingletonAsync<Box<User>>(() => Hive.openBox<User>('user_box'));

  getIt.registerSingletonAsync<AuthLocalSource>(() async {
    final box = await getIt.getAsync<Box<User>>();
    return AuthLocalSourceImpl(box);
  });
  getIt.registerLazySingletonAsync<AuthRemoteSource>(() async {
    return AuthRemoteSourceImpl(getIt<SupabaseService>().client);
  });

  await getIt.allReady();
}
