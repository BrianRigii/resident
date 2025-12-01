import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/buttons.dart';
import 'package:resident/core/widgets/cards.dart';
import 'package:resident/core/widgets/common_widgets.dart';
import 'package:resident/core/widgets/input_fields.dart';

/// Design System Showcase
/// This screen demonstrates all UI components and design tokens
class DesignShowcase extends StatelessWidget {
  const DesignShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Design System Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Colors Section
          const SectionHeader(
            title: 'Colors',
            subtitle: 'Color palette and usage',
          ),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _ColorSwatch('Primary', AppColors.primary),
              _ColorSwatch('Secondary', AppColors.secondary),
              _ColorSwatch('Success', AppColors.success),
              _ColorSwatch('Warning', AppColors.warning),
              _ColorSwatch('Error', AppColors.error),
              _ColorSwatch('Info', AppColors.info),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // Typography Section
          const SectionHeader(
            title: 'Typography',
            subtitle: 'Text styles and hierarchy',
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                Text('Display 1', style: AppTextStyles.display1),
                Text('Heading 1', style: AppTextStyles.h1),
                Text('Heading 2', style: AppTextStyles.h2),
                Text('Heading 3', style: AppTextStyles.h3),
                Text('Heading 4', style: AppTextStyles.h4),
                Text('Heading 5', style: AppTextStyles.h5),
                Text(
                  'Body 1 - Regular text for paragraphs and content',
                  style: AppTextStyles.body1,
                ),
                Text(
                  'Body 2 - Smaller text for secondary content',
                  style: AppTextStyles.body2,
                ),
                Text('Subtitle 1', style: AppTextStyles.subtitle1),
                Text(
                  'Caption - Small text for hints',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Buttons Section
          const SectionHeader(
            title: 'Buttons',
            subtitle: 'Primary, secondary, and tertiary actions',
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                const PrimaryButton(text: 'Primary Button', icon: Icons.check),
                const SecondaryButton(
                  text: 'Secondary Button',
                  icon: Icons.edit,
                ),
                const TertiaryButton(
                  text: 'Tertiary Button',
                  icon: Icons.arrow_forward,
                ),
                const PrimaryButton(text: 'Loading...', isLoading: true),
                Row(
                  spacing: AppSpacing.sm,
                  children: const [
                    IconButtonCircular(icon: Icons.favorite),
                    IconButtonCircular(
                      icon: Icons.share,
                      backgroundColor: AppColors.primary,
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Input Fields Section
          const SectionHeader(
            title: 'Input Fields',
            subtitle: 'Text inputs and forms',
          ),
          AppCard(
            child: Column(
              spacing: AppSpacing.md,
              children: [
                AppTextField(
                  label: 'Email',
                  hint: 'your@email.com',
                  prefixIcon: Icons.email_outlined,
                ),
                AppTextField(
                  label: 'Password',
                  hint: 'Enter password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SearchField(hint: 'Search properties...'),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Cards Section
          const SectionHeader(
            title: 'Cards',
            subtitle: 'Various card components',
          ),
          Column(
            spacing: AppSpacing.md,
            children: [
              const StatsCard(
                title: 'Total Properties',
                value: '24',
                icon: Icons.apartment,
                color: AppColors.primary,
                trend: '+12%',
                trendPositive: true,
              ),
              InfoCard(
                icon: Icons.notifications_active,
                title: 'Notifications',
                value: '5 unread',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xl),

          // Status Badges Section
          const SectionHeader(
            title: 'Status Badges',
            subtitle: 'Status indicators and labels',
          ),
          AppCard(
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: const [
                StatusBadge(
                  label: 'Occupied',
                  color: AppColors.statusOccupied,
                  icon: Icons.check_circle,
                ),
                StatusBadge(
                  label: 'Vacant',
                  color: AppColors.statusVacant,
                  icon: Icons.circle_outlined,
                  outlined: true,
                ),
                StatusBadge(
                  label: 'Maintenance',
                  color: AppColors.statusMaintenance,
                  icon: Icons.build,
                ),
                StatusBadge(label: 'Reserved', color: AppColors.statusReserved),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Empty States Section
          const SectionHeader(
            title: 'Empty States',
            subtitle: 'Feedback when no content is available',
          ),
          AppCard(
            child: EmptyState(
              icon: Icons.inbox,
              title: 'No items found',
              description: 'There are no items to display at this time',
              actionText: 'Add New',
              onAction: () {},
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Spacing Guide
          const SectionHeader(
            title: 'Spacing',
            subtitle: '4px unit-based spacing system',
          ),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.sm,
              children: [
                _SpacingDemo('XS (4px)', AppSpacing.xs),
                _SpacingDemo('SM (8px)', AppSpacing.sm),
                _SpacingDemo('MD (16px)', AppSpacing.md),
                _SpacingDemo('LG (24px)', AppSpacing.lg),
                _SpacingDemo('XL (32px)', AppSpacing.xl),
                _SpacingDemo('XXL (48px)', AppSpacing.xxl),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorSwatch(this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.border),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(name, style: AppTextStyles.caption),
      ],
    );
  }
}

class _SpacingDemo extends StatelessWidget {
  final String label;
  final double size;

  const _SpacingDemo(this.label, this.size);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label, style: AppTextStyles.caption)),
        Container(
          width: size,
          height: 24,
          color: AppColors.primary.withOpacity(0.5),
        ),
      ],
    );
  }
}
