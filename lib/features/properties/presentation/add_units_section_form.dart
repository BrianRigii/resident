import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/features/properties/presentation/add_property_notifier.dart';
import 'package:resident/features/units/presentation/add_unit_form.dart';
import 'package:resident/features/units/presentation/unit_card.dart';

class AddUnitsSectionForm extends StatelessWidget {
  const AddUnitsSectionForm({super.key});

  void _showAddUnitDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddUnitForm(
        onSubmit: (Map<String, dynamic> unitData) {
          context.read<AddPropertyNotifier>().addUnit(unitData);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AddPropertyNotifier addPropertyNotifier = context
        .watch<AddPropertyNotifier>();
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Property Units', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Add units to your property (optional)',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.warning.withAlpha(51)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.warning,
                  size: 20,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'You can skip this step and add units later',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          if (addPropertyNotifier.units.isEmpty)
            Container(
              padding: EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: AppColors.border,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.apartment,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text('No units yet', style: AppTextStyles.h6),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    'Add units to organize your property better',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              itemCount: addPropertyNotifier.units.length,
              itemBuilder: (_, index) {
                final unit = addPropertyNotifier.units[index];
                return UnitCard(unit: unit);
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () => _showAddUnitDialog(context),
            icon: Icon(Icons.add),
            label: Text(
              addPropertyNotifier.units.isEmpty
                  ? 'Add Your First Unit'
                  : 'Add Another Unit',
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              side: BorderSide(color: AppColors.primary, width: 2),
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
