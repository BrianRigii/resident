import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:resident/core/dependencies.dart';
import 'package:resident/core/router.dart';

import 'package:resident/core/theme/app_theme.dart';
import 'package:resident/features/auth/presentation/auth_notifier.dart';


import 'package:resident/features/auth/domain/auth_service.dart';

import 'package:resident/features/properties/presentation/property_notifier.dart';

import 'package:resident/features/properties/domain/property_service.dart';
import 'package:resident/features/units/domain/unit_service.dart';
import 'package:resident/features/units/notifiers/unit_notifier.dart';

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
        ChangeNotifierProvider<AuthNotifier>(
          create: (context) =>
              AuthNotifier(authService: getIt.get<AuthService>()),
        ),
        ChangeNotifierProvider<PropertyNotifier>(
          create: (context) => PropertyNotifier(
            propertyService: getIt.getAsync<PropertyService>(),
          ),
        ),
        ChangeNotifierProvider<UnitNotifier>(
          create: (context) =>
              UnitNotifier(unitService: getIt.get<UnitService>()),
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
