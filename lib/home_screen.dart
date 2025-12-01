import 'package:flutter/material.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/buttons.dart';
import 'package:resident/core/widgets/cards.dart';
import 'package:resident/core/widgets/common_widgets.dart';
import 'package:resident/core/widgets/navigation.dart';

class HomeScreen extends StatefulWidget {
  static const String path = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardView(),
    const PropertiesView(),
    const UnitsView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _screens[_currentIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? AppFAB(
              icon: _currentIndex == 0 ? Icons.add : Icons.add_business,
              onPressed: () {
                // TODO: Add property or unit
              },
              tooltip: _currentIndex == 0 ? 'Add Unit' : 'Add Property',
            )
          : null,
    );
  }
}

// Dashboard View
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                childAspectRatio: 1.4,
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
                action: TertiaryButton(text: 'View All', onPressed: () {}),
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
                            color: AppColors.primary.withOpacity(0.1),
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
    );
  }
}

// Properties View Placeholder
class PropertiesView extends StatelessWidget {
  const PropertiesView({super.key});

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

// Units View Placeholder
class UnitsView extends StatelessWidget {
  const UnitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
            description: 'Add properties first, then create units within them',
          ),
        ),
      ],
    );
  }
}

// Profile View Placeholder
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text('Profile', style: AppTextStyles.h4),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Profile Header
              AppCard(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text('John Doe', style: AppTextStyles.h5),
                    Text(
                      'john.doe@example.com',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Settings Options
              InfoCard(
                icon: Icons.settings,
                title: 'Settings',
                value: 'Account preferences',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoCard(
                icon: Icons.help_outline,
                title: 'Help & Support',
                value: 'Get assistance',
                onTap: () {},
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoCard(
                icon: Icons.logout,
                title: 'Sign Out',
                value: 'Logout from account',
                iconColor: AppColors.error,
                onTap: () {},
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
