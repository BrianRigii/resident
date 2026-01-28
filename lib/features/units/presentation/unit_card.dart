import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/features/properties/presentation/add_property_notifier.dart';
import 'package:resident/features/units/models/unit.dart';

class UnitCard extends StatelessWidget {
  final Unit unit;
  const UnitCard({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(Icons.meeting_room, color: AppColors.primary, size: 20),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.name, style: AppTextStyles.subtitle1),

                Text(
                  '\$${unit.rentPrice}/month',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.error),
            onPressed: () =>
                context.read<AddPropertyNotifier>().removeUnit(unit.id),
          ),
        ],
      ),
    );
  }
}
