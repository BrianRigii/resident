import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';

class HandleBar extends StatelessWidget {
  const HandleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.textTertiary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
