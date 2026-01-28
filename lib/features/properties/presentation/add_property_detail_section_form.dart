import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/toggle_option.dart';

import 'package:resident/features/properties/presentation/add_property_notifier.dart';

class AddPropertyDetailSectionForm extends StatefulWidget {
  final TextEditingController nameController;

  const AddPropertyDetailSectionForm({super.key, required this.nameController});

  @override
  State<AddPropertyDetailSectionForm> createState() =>
      _AddPropertyDetailSectionFormState();
}

class _AddPropertyDetailSectionFormState
    extends State<AddPropertyDetailSectionForm> {
  AddPropertyNotifier get notifier => context.watch<AddPropertyNotifier>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Property Details', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Let\'s start with the basic information about your property',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xl),
          TextFormField(
            controller: widget.nameController,
            decoration: InputDecoration(
              labelText: 'Property Name *',
              hintText: 'e.g., Sunset Apartments',
              prefixIcon: Icon(Icons.business, color: AppColors.primary),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Property name is required';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.lg),
          Text('Are you the landlord/owner?', style: AppTextStyles.subtitle1),
          SizedBox(height: AppSpacing.sm),
          Text(
            'This helps us customize your experience',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Column(
              children: [
                ToggleOption(
                  icon: Icons.person,
                  title: 'Yes, I\'m the landlord',
                  subtitle: 'I own and manage this property',
                  value: true,
                  selected: notifier.isLandLord,
                  onTap: () => notifier.isLandLord = true,
                ),
                Divider(height: 1, color: AppColors.border),
                ToggleOption(
                  icon: Icons.people,
                  title: 'No, I\'m a property manager',
                  subtitle: 'I manage on behalf of the owner',
                  value: false,
                  selected: !notifier.isLandLord,
                  onTap: () => notifier.isLandLord = false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
