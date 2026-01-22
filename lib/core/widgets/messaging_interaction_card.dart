import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/home_screen_widgets.dart';

class MessagingInteractionCard extends StatelessWidget {
  const MessagingInteractionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      delay: 100,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha((75)),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    Icons.message_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Messaging Center',
                        style: AppTextStyles.h6.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Connected',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white, size: 20),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: MessagingActionButton(
                    icon: Icons.phone,
                    label: 'WhatsApp',

                    onTap: () {},
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: MessagingActionButton(
                    icon: Icons.sms_rounded,
                    label: 'SMS',

                    onTap: () {},
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: MessagingActionButton(
                    icon: Icons.campaign_rounded,
                    label: 'Broadcast',

                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
