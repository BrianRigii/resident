import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/cards.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text('Profile', style: AppTextStyles.h4),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Profile Header
              AppCard(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.primary.withAlpha(25),
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text('John Doe', style: AppTextStyles.h5),
                    Text(
                      'john.doe@example.com',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Settings Options
              InfoCard(
                icon: Icons.settings,
                title: 'Settings',
                value: 'Account preferences',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoCard(
                icon: Icons.help_outline,
                title: 'Help & Support',
                value: 'Get assistance',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoCard(
                icon: Icons.logout,
                title: 'Sign Out',
                value: 'Logout from account',
                iconColor: AppColors.error,
                onTap: () {},
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
