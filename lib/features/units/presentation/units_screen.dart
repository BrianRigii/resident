import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/common_widgets.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text('Units', style: AppTextStyles.h4),
        ),
        const SliverFillRemaining(
          child: EmptyState(
            icon: Icons.meeting_room,
            title: 'No Units Yet',
            description: 'Add properties first, then create units within them',
          ),
        ),
      ],
    );
  }
}
