import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/common_widgets.dart';
import 'package:resident/features/properties/presentation/add_property_form.dart';
import 'package:resident/features/properties/presentation/property_notifier.dart';

class PropertiesScreen extends StatefulWidget {
  static const path = '/properties';
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  void _onAddProperty(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,

      sheetAnimationStyle: AnimationStyle(
        curve: Curves.bounceInOut,
        duration: const Duration(seconds: 1),
      ),
      builder: (context) => AddPropertyForm(onSubmit: _handleSubmitProperty),
    );
  }

  void _handleSubmitProperty(Map<String, dynamic> formData) async {
    PropertyNotifier propertyNotifier = context.read<PropertyNotifier>();
    propertyNotifier.addProperty(formData);
  }

  Future<void> _refreshProperties() async {
    context.read<PropertyNotifier>().fetchProperties();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PropertyNotifier>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddProperty(context),
        child: const Icon(Icons.add),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text('Properties', style: AppTextStyles.h4),
          ),
          SliverFillRemaining(
            child: RefreshIndicator(
              onRefresh: _refreshProperties,
              child: EmptyState(
                icon: Icons.apartment,
                title: 'No Properties Yet',
                description: 'Add your first property to get started',
                actionText: 'Add Property',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
