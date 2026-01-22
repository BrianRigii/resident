import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/widgets/modern_stats_card.dart';
import 'package:resident/home_screen_widgets.dart';

class QuickStatsGrid extends StatelessWidget {
  const QuickStatsGrid({super.key});

  final int _totalProperties = 12;
  final int _totalUnits = 80;
  final int _occupiedUnits = 42;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.1,
      children: [
        AnimatedCard(
          delay: 300,
          child: ModernStatsCard(
            title: 'Total Properties',
            value: '$_totalProperties',
            icon: Icons.apartment_rounded,
            gradient: AppColors.primaryGradient,
            trend: '+2',
            trendPositive: true,
          ),
        ),
        AnimatedCard(
          delay: 350,
          child: ModernStatsCard(
            title: 'Total Units',
            value: '$_totalUnits',
            icon: Icons.meeting_room_rounded,
            gradient: AppColors.primaryGradient,
            trend: '+5',
            trendPositive: true,
          ),
        ),
        AnimatedCard(
          delay: 400,
          child: ModernStatsCard(
            title: 'Occupied',
            value: '$_occupiedUnits',
            icon: Icons.check_circle_rounded,
            gradient: AppColors.primaryGradient,
            trend:
                '${(_occupiedUnits / _totalUnits * 100).toStringAsFixed(1)}%',
          ),
        ),
        AnimatedCard(
          delay: 450,
          child: ModernStatsCard(
            title: 'Vacant',
            value: '${_totalUnits - _occupiedUnits}',
            icon: Icons.info_rounded,
            gradient: AppColors.primaryGradient,
            trend:
                '${((_totalUnits - _occupiedUnits) / _totalUnits * 100).toStringAsFixed(1)}%',
          ),
        ),
      ],
    );
  }
}
