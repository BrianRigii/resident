import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/features/auth/domain/auth_service.dart';

class AuthForm extends StatefulWidget {
  final AuthMode authMode;
  final Function toggleAuthMode;
  final Function(Map<String, dynamic> formData) onSubmit;
  const AuthForm({
    super.key,
    required this.authMode,
    required this.toggleAuthMode,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  void togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        spacing: 8.0,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: togglePasswordVisibility,
              ),
            ),
            obscureText: hidePassword,
          ),
          ElevatedButton(
            onPressed: () {},
            child:
                context.select<AuthService, bool>(
                  (authService) => authService.isAuthenticating,
                )
                ? const CircularProgressIndicator()
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

enum AuthMode { signIn, signUp }
