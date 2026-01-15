import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/cards.dart';

class AddSelectionWidget extends StatelessWidget {
  final ScrollController scrollController;
  final DraggableScrollableController sheetController;

  const AddSelectionWidget({
    super.key,
    required this.scrollController,
    required this.sheetController,
  });

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
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          Text('Add New', style: AppTextStyles.h5, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Choose what you want to add',
            style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Action Buttons
          _AddActionButton(
            icon: Icons.add_business,
            title: 'Add Property',
            subtitle: 'Add a new property to manage',
            color: AppColors.primary,
            onTap: () {
              sheetController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              // TODO: Navigate to add property screen
            },
          ),
          const SizedBox(height: AppSpacing.md),
          _AddActionButton(
            icon: Icons.meeting_room,
            title: 'Add Unit',
            subtitle: 'Add a new unit to a property',
            color: AppColors.info,
            onTap: () {
              sheetController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              // TODO: Navigate to add unit screen
            },
          ),
          const SizedBox(height: AppSpacing.md),
          _AddActionButton(
            icon: Icons.person_add,
            title: 'Add Tenant',
            subtitle: 'Add a new tenant to a unit',
            color: AppColors.success,
            onTap: () {
              sheetController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              // TODO: Navigate to add tenant screen
            },
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
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xs,
              children: [
                Text(title, style: AppTextStyles.subtitle1),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}
