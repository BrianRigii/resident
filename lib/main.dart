import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/router.dart';
import 'package:resident/core/supabase/supabase.dart';
import 'package:resident/features/auth/auth_api.dart';
import 'package:resident/features/auth/domain/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SupabaseService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthApiImpl(SupabaseService.instance.client)),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthServiceImpl(context.read<AuthApi>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Resident',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: router,
      ),
    );
  }
}
