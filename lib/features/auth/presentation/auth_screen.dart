import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/presentation/auth_form.dart';
import 'package:resident/features/auth/presentation/auth_notifier.dart';

import 'package:resident/splash_screen.dart';

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
    AuthNotifier authNotifier = context.read<AuthNotifier>();

    User? user = (authMode == AuthMode.signIn
        ? await authNotifier.signIn(formData)
        : await authNotifier.signUp(formData));
    if (user == null) return;
    if (mounted && user.id.isNotEmpty) context.go(SplashScreen.path);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              isDesktop ? AppSpacing.xxxl : AppSpacing.lg,
            ),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppSpacing.xl,
                  children: [
                    // Logo and Title Section
                    Column(
                      spacing: AppSpacing.sm,
                      children: [
                        // Logo
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusLg,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withAlpha(30),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.apartment,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        // Title
                        Text(
                          'Resident',
                          style: AppTextStyles.display2.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        // Subtitle
                        Text(
                          authMode == AuthMode.signIn
                              ? 'Sign in to manage your properties'
                              : 'Create an account to get started',
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    // Auth Form Card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLg,
                        ),
                        border: Border.all(color: AppColors.border, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(
                        isDesktop ? AppSpacing.xl : AppSpacing.lg,
                      ),
                      child: AuthForm(
                        authMode: authMode,
                        toggleAuthMode: toggleAuthMode,
                        onSubmit: _handleAuthSubmission,
                      ),
                    ),

                    // Footer
                    Text(
                      '© 2025 Resident. Property Management Made Simple.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
