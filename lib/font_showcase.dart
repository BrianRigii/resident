import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';

/// Typography showcase demonstrating Montserrat and Inter fonts
class FontShowcase extends StatelessWidget {
  const FontShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Font Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Montserrat Showcase
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                Text(
                  'Montserrat Font Family',
                  style: AppTextStyles.h4.copyWith(color: AppColors.primary),
                ),
                const Divider(),
                Text(
                  'Used for headings and emphasis',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Display Styles
                const _FontSample(
                  label: 'Display 1',
                  style: AppTextStyles.display1,
                  sample: 'Property Management',
                ),
                const _FontSample(
                  label: 'Display 2',
                  style: AppTextStyles.display2,
                  sample: 'Modern & Minimal',
                ),

                const SizedBox(height: AppSpacing.md),

                // Headings
                const _FontSample(
                  label: 'Heading 1',
                  style: AppTextStyles.h1,
                  sample: 'Dashboard Overview',
                ),
                const _FontSample(
                  label: 'Heading 2',
                  style: AppTextStyles.h2,
                  sample: 'Your Properties',
                ),
                const _FontSample(
                  label: 'Heading 3',
                  style: AppTextStyles.h3,
                  sample: 'Recent Activity',
                ),
                const _FontSample(
                  label: 'Heading 4',
                  style: AppTextStyles.h4,
                  sample: 'Property Details',
                ),
                const _FontSample(
                  label: 'Heading 5',
                  style: AppTextStyles.h5,
                  sample: 'Unit Information',
                ),
                const _FontSample(
                  label: 'Heading 6',
                  style: AppTextStyles.h6,
                  sample: 'Section Title',
                ),

                const SizedBox(height: AppSpacing.md),

                // Button Style
                const _FontSample(
                  label: 'Button',
                  style: AppTextStyles.button,
                  sample: 'SIGN IN TO ACCOUNT',
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Inter Showcase
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                Text(
                  'Inter Font Family',
                  style: AppTextStyles.h4.copyWith(color: AppColors.info),
                ),
                const Divider(),
                Text(
                  'Used for body text and UI elements',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Body Text
                const _FontSample(
                  label: 'Body 1',
                  style: AppTextStyles.body1,
                  sample:
                      'The quick brown fox jumps over the lazy dog. This is the primary body text style used throughout the application for main content.',
                ),
                const _FontSample(
                  label: 'Body 2',
                  style: AppTextStyles.body2,
                  sample:
                      'Slightly smaller body text for secondary information and supporting content. Maintains excellent readability at smaller sizes.',
                ),

                const SizedBox(height: AppSpacing.md),

                // Subtitles
                const _FontSample(
                  label: 'Subtitle 1',
                  style: AppTextStyles.subtitle1,
                  sample: 'Emphasized body text with medium weight',
                ),
                const _FontSample(
                  label: 'Subtitle 2',
                  style: AppTextStyles.subtitle2,
                  sample: 'Smaller emphasized text for labels',
                ),

                const SizedBox(height: AppSpacing.md),

                // Small Text
                const _FontSample(
                  label: 'Caption',
                  style: AppTextStyles.caption,
                  sample: 'Small text for timestamps, hints, and helper text',
                ),
                const _FontSample(
                  label: 'Overline',
                  style: AppTextStyles.overline,
                  sample: 'CATEGORY LABEL',
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),

          // Usage Example
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                Text('Real-World Example', style: AppTextStyles.h5),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.sm,
                    children: [
                      Text('Sunset Apartments', style: AppTextStyles.h4),
                      Text(
                        '123 Main Street, Downtown',
                        style: AppTextStyles.subtitle2,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'A modern residential property featuring 48 units across 6 floors. Located in the heart of downtown with easy access to public transportation and local amenities.',
                        style: AppTextStyles.body1,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Last updated 2 hours ago',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _FontSample extends StatelessWidget {
  final String label;
  final TextStyle style;
  final String sample;

  const _FontSample({
    required this.label,
    required this.style,
    required this.sample,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.xs,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
                ),
                child: Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${style.fontFamily} • ${style.fontSize}px • w${style.fontWeight?.value}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          Text(sample, style: style),
        ],
      ),
    );
  }
}
