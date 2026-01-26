import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';

import 'package:resident/features/properties/models/property.dart';

import 'package:resident/features/properties/presentation/property_card.dart';
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
      context.read<PropertyNotifier>().fetchProperties(userInitiated: true);
    });
  }

  Future<void> _refreshProperties() async {
    await context.read<PropertyNotifier>().fetchProperties(userInitiated: true);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<PropertyNotifier>();

    return Scaffold(
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
            SliverFillRemaining(
              child: ListView.builder(
                itemCount: notifier.properties.length,
                itemBuilder: (context, index) {
                  Property property = notifier.properties[index];
                  return Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: PropertyCard(property: property),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
