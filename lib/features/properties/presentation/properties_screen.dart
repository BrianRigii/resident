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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyNotifier>().fetchProperties(
        userInitiated: true,
        replace: true,
      );
    });
  }

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
    await context.read<PropertyNotifier>().fetchProperties(
      forceRefresh: true,
      userInitiated: true,
      replace: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<PropertyNotifier>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddProperty(context),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProperties,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.background,
              elevation: 0,
              title: Text('Properties', style: AppTextStyles.h4),
            ),
            if (notifier.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (notifier.properties.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.apartment,
                  title: 'No Properties Yet',
                  description: 'Add your first property to get started',
                  actionText: 'Add Property',
                ),
              )
            else
              SliverList.builder(
                itemCount: notifier.properties.length,
                itemBuilder: (context, index) {
                  final property = notifier.properties[index];
                  return ListTile(
                    title: Text(property.name, style: AppTextStyles.body1),
                    subtitle: Text(
                      property.address,
                      style: AppTextStyles.caption,
                    ),
                    leading: const Icon(
                      Icons.home_work,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
