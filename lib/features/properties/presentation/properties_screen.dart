import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/common_widgets.dart';

class PropertiesScreen extends StatelessWidget {
  static const path = '/properties';
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text('Properties', style: AppTextStyles.h4),
        ),
        const SliverFillRemaining(
          child: EmptyState(
            icon: Icons.apartment,
            title: 'No Properties Yet',
            description: 'Add your first property to get started',
            actionText: 'Add Property',
          ),
        ),
      ],
    );
  }
}
