import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/common_widgets.dart';

class ReportsScreen extends StatelessWidget {
  static const String path = '/reports';
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text('Reports', style: AppTextStyles.h4),
          ),
          SliverFillRemaining(
            child: EmptyState(
              icon: Icons.meeting_room,
              title: 'No Reports Yet',
              description:
                  'Add properties first, then create reports within them',
            ),
          ),
        ],
      ),
    );
  }
}
