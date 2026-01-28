import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';

class AddLocationSectionForm extends StatelessWidget {
  final TextEditingController addressController;
  const AddLocationSectionForm({super.key, required this.addressController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Property Location', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Where is your property located?',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xl),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'Full Address *',
              hintText: '123 Main Street, City, State, ZIP',
              prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
            ),
            maxLines: 3,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.lg),
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.info.withAlpha(51)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'A complete address helps with tenant communications and documentation',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
