import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resident/features/auth/domain/auth_service.dart';
import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/presentation/auth_form.dart';
import 'package:resident/home_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String path = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode authMode = AuthMode.signIn;
  void toggleAuthMode() {
    setState(() {
      authMode = authMode == AuthMode.signIn
          ? AuthMode.signUp
          : AuthMode.signIn;
    });
  }

  void _handleAuthSubmission(Map<String, dynamic> formData) async {
    AuthService authService = context.read<AuthService>();
    User user = await authService.login(formData);
    if (mounted && user.id.isNotEmpty) context.go(HomeScreen.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AuthForm(
          authMode: authMode,
          toggleAuthMode: toggleAuthMode,
          onSubmit: _handleAuthSubmission,
        ),
      ),
    );
  }
}
