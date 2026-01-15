import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/add_selection_widget.dart';
import 'package:resident/core/widgets/buttons.dart';
import 'package:resident/core/widgets/cards.dart';
import 'package:resident/core/widgets/common_widgets.dart';

class HomeScaffold extends StatelessWidget {
  static const String path = '/home';
  final StatefulNavigationShell navigationShell;
  const HomeScaffold({super.key, required this.navigationShell});

  final items = const [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Properties'),
    BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Units'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
      body: navigationShell,
    );
  }
}

// Dashboard View
class DashboardScreen extends StatefulWidget {
  static const String path = '/dashboard';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  void _onAddActionPressed() {
    _sheetController.animateTo(
      0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddActionPressed,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                backgroundColor: AppColors.background,
                elevation: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dashboard', style: AppTextStyles.h4),
                    Text(
                      'Welcome back!',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // TODO: Show notifications
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Stats Cards
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,

                      children: const [
                        StatsCard(
                          title: 'Total Properties',
                          value: '12',
                          icon: Icons.apartment,
                          color: AppColors.primary,
                          trend: '+2',
                          trendPositive: true,
                        ),
                        StatsCard(
                          title: 'Total Units',
                          value: '48',
                          icon: Icons.meeting_room,
                          color: AppColors.info,
                          trend: '+5',
                          trendPositive: true,
                        ),
                        StatsCard(
                          title: 'Occupied',
                          value: '42',
                          icon: Icons.check_circle_outline,
                          color: AppColors.success,
                          trend: '87.5%',
                        ),
                        StatsCard(
                          title: 'Vacant',
                          value: '6',
                          icon: Icons.gpp_maybe_outlined,
                          color: AppColors.warning,
                          trend: '12.5%',
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Recent Activity Section
                    SectionHeader(
                      title: 'Recent Activity',
                      subtitle: 'Latest updates from your properties',
                      action: TertiaryButton(
                        text: 'View All',
                        onPressed: () {},
                      ),
                    ),

                    // Activity List
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        return AppCard(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.sm),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(25),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusMd,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.notifications_active,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: AppSpacing.xs,
                                  children: [
                                    Text(
                                      'New tenant moved in',
                                      style: AppTextStyles.subtitle1,
                                    ),
                                    Text(
                                      'Unit 4B - Sunset Apartments',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '2h ago',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Quick Actions
                    const SectionHeader(
                      title: 'Quick Actions',
                      subtitle: 'Common tasks',
                    ),

                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      childAspectRatio: 1.8,
                      children: [
                        InfoCard(
                          icon: Icons.add_business,
                          title: 'Add Property',
                          value: 'New',
                          iconColor: AppColors.primary,
                          onTap: () {},
                        ),
                        InfoCard(
                          icon: Icons.meeting_room,
                          title: 'Add Unit',
                          value: 'New',
                          iconColor: AppColors.info,
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xxxl),
                  ]),
                ),
              ),
            ],
          ),

          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.0,
            minChildSize: 0.0,
            maxChildSize: 0.5,

            snap: true,
            snapSizes: const [0.5],
            builder: (context, scrollController) {
              return AddSelectionWidget(
                scrollController: scrollController,
                sheetController: _sheetController,
              );
            },
          ),
        ],
      ),
    );
  }
}
