import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/common_widgets.dart';
import 'package:resident/features/units/presentation/add_unit_form.dart';

class UnitsScreen extends StatelessWidget {
  static const path = '/units';
  const UnitsScreen({super.key});

  void _onAddUnit(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddUnitForm(onSubmit: _handleSubmitUnit),
    );
  }

  void _handleSubmitUnit(Map<String, dynamic> formData) {
    // Handle unit submission logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddUnit(context),
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
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
              description:
                  'Add properties first, then create units within them',
            ),
          ),
        ],
      ),
    );
  }
}
