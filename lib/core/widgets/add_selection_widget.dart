import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/handle_bar.dart';

class AddSelectionWidget extends StatelessWidget {
  const AddSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          const HandleBar(),

          // Divider
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.textTertiary.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                _AddActionButton(
                  icon: Icons.add_business_rounded,
                  title: 'Add Property',
                  subtitle: 'Add a new property to manage',
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _AddActionButton(
                  icon: Icons.meeting_room_rounded,
                  title: 'Add Unit',
                  subtitle: 'Add a new unit to a property',
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to add unit screen
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _AddActionButton(
                  icon: Icons.person_add_rounded,
                  title: 'Add Tenant',
                  subtitle: 'Add a new tenant to a unit',
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to add tenant screen
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + AppSpacing.xl,
          ),
        ],
      ),
    );
  }
}

class _AddActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AddActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.15),
                      color.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.subtitle1.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: AppColors.textTertiary.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
