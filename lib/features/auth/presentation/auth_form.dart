import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/buttons.dart';
import 'package:resident/core/widgets/common_widgets.dart';
import 'package:resident/core/widgets/input_fields.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit({
        'email': _emailController.text,
        'password': _passwordController.text,
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticating = context.select<AuthService, bool>(
      (authService) => authService.isAuthenticating,
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: AppSpacing.lg,
        children: [
          // Email Field
          AppTextField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'you@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
            enabled: !isAuthenticating,
          ),

          // Password Field
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: _hidePassword,
            validator: _validatePassword,
            enabled: !isAuthenticating,
            suffixIcon: IconButton(
              icon: Icon(
                _hidePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textTertiary,
                size: 20,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),

          // Forgot Password (Sign In Only)
          if (widget.authMode == AuthMode.signIn)
            Align(
              alignment: Alignment.centerRight,
              child: TertiaryButton(
                text: 'Forgot password?',
                onPressed: () {
                  // TODO: Implement forgot password
                },
              ),
            ),

          const SizedBox(height: AppSpacing.sm),

          // Submit Button
          PrimaryButton(
            text: widget.authMode == AuthMode.signIn
                ? 'Sign In'
                : 'Create Account',
            onPressed: _handleSubmit,
            isLoading: isAuthenticating,
            fullWidth: true,
            icon: widget.authMode == AuthMode.signIn
                ? Icons.login
                : Icons.person_add,
          ),

          // Divider
          const DividerWithText(text: 'OR'),

          // Toggle Auth Mode
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.authMode == AuthMode.signIn
                    ? "Don't have an account?"
                    : "Already have an account?",
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              TertiaryButton(
                text: widget.authMode == AuthMode.signIn
                    ? 'Sign Up'
                    : 'Sign In',
                onPressed: () => widget.toggleAuthMode(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum AuthMode { signIn, signUp }
