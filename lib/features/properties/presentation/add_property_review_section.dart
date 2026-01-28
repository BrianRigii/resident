import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/features/properties/presentation/add_property_notifier.dart';

class AddPropertyReviewSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController _addressController;
  const AddPropertyReviewSection({
    super.key,
    required this.nameController,
    required TextEditingController addressController,
  }) : _addressController = addressController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Review & Confirm', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Please review your property details',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xl),
          _ReviewCard(
            icon: Icons.business,
            title: 'Property Details',
            items: [
              _ReviewItem('Name', nameController.text),
              _ReviewItem(
                'Owner Status',
                context.read<AddPropertyNotifier>().isLandLord
                    ? 'Landlord/Owner'
                    : 'Property Manager',
              ),
            ],
            onEdit: () => context.read<AddPropertyNotifier>().goToStep(0),
          ),
          SizedBox(height: AppSpacing.md),
          _ReviewCard(
            icon: Icons.location_on,
            title: 'Location',
            items: [_ReviewItem('Address', _addressController.text)],
            onEdit: () => context.read<AddPropertyNotifier>().goToStep(1),
          ),
          SizedBox(height: AppSpacing.md),
          _ReviewCard(
            icon: Icons.apartment,
            title: 'Units',
            items: [
              _ReviewItem(
                'Total Units',
                context.read<AddPropertyNotifier>().units.isEmpty
                    ? 'No units added'
                    : '${context.read<AddPropertyNotifier>().units.length} unit(s)',
              ),
            ],
            onEdit: () => context.read<AddPropertyNotifier>().goToStep(2),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<_ReviewItem> items;

  final VoidCallback onEdit;
  const _ReviewCard({
    required this.icon,
    required this.title,
    required this.items,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(child: Text(title, style: AppTextStyles.h6)),
              TextButton.icon(
                onPressed: onEdit,
                icon: Icon(Icons.edit, size: 16),
                label: Text('Edit'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          ...items.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      item.label,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(child: Text(item.value, style: AppTextStyles.body2)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ReviewItem {
  final String label;
  final String value;
  _ReviewItem(this.label, this.value);
}
