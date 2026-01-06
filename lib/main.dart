import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:resident/core/dependencies.dart';
import 'package:resident/core/router.dart';
import 'package:resident/core/supabase/supabase.dart';
import 'package:resident/core/theme/app_theme.dart';

import 'package:resident/features/auth/sources/auth_remote_source.dart';
import 'package:resident/features/auth/domain/auth_service.dart';
import 'package:resident/features/auth/sources/auth_local_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthServiceImpl(
            getIt<AuthRemoteSource>(),
            getIt<AuthLocalSource>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Resident',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
