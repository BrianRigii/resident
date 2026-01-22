import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/home_screen_widgets.dart';

class AnalyticsSection extends StatelessWidget {
  AnalyticsSection({super.key});

  final topDefaulters = [
    {'name': 'Unit 1A - Sarah Wilson', 'amount': 30000, 'months': 1},
    {'name': 'Unit 4D - Tom Brown', 'amount': 26000, 'months': 1},
    {'name': 'Unit 7B - Lisa Anderson', 'amount': 52000, 'months': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      delay: 600,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withAlpha(25),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    Icons.analytics_rounded,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Text('Analytics', style: AppTextStyles.h6),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Collection Trend Chart
            Text('Occupancy (Last 6 Months)', style: AppTextStyles.subtitle2),
            SizedBox(height: AppSpacing.sm),
            CollectionTrendChart(),
            SizedBox(height: AppSpacing.lg),

            // Average Days to Pay
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer, color: AppColors.info, size: 16),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              'Avg Days to Pay',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.info,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          '5.2 days',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.success.withAlpha(25),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: AppColors.success,
                              size: 16,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              'On-Time Rate',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          '87.5%',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Top Defaulters
            Text('Top Defaulters', style: AppTextStyles.subtitle2),
            SizedBox(height: AppSpacing.sm),
            ...topDefaulters.map((defaulter) {
              return DefaulterItem(
                name: defaulter['name'] as String,
                amount: defaulter['amount'] as int,
                months: defaulter['months'] as int,
              );
            }),
          ],
        ),
      ),
    );
  }
}
