import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';

import 'package:resident/core/widgets/add_selection_widget.dart';
import 'package:resident/core/widgets/analytics_section.dart';
import 'package:resident/core/widgets/financial_summary_section.dart';
import 'package:resident/core/widgets/loading_screen.dart';
import 'package:resident/core/widgets/messaging_interaction_card.dart';
import 'package:resident/features/auth/presentation/auth_notifier.dart';

import 'package:resident/home_screen_widgets.dart';

class HomeScaffold extends StatelessWidget {
  static const String path = '/home';
  final StatefulNavigationShell navigationShell;
  const HomeScaffold({super.key, required this.navigationShell});

  final items = const [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'Properties'),
    BottomNavigationBarItem(icon: Icon(Icons.add_chart), label: 'Reports'),
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

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  bool _isLoading = true;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Mock data

  final int _totalUnits = 48;
  final int _occupiedUnits = 42;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Simulate data loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _isLoading = false);
        _fadeController.forward();
      }
    });
  }

  void _onAddActionPressed() {
    showModalBottomSheet(
      useRootNavigator: true,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,

      builder: (_) {
        return const AddSelectionWidget();
      },
    );
  }

  @override
  void dispose() {
    _sheetController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withAlpha(25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _onAddActionPressed,
          backgroundColor: Colors.transparent,

          child: const Icon(Icons.add, size: 28),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.surfaceGradient),
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: MediaQuery.sizeOf(context).height * 0.2,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton.outlined(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () {
                    context.push('/settings');
                  },
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resident',
                            style: AppTextStyles.h3.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Welcome back, ${context.read<AuthNotifier>().currentUser?.name ?? ""}! 👋',
                            style: AppTextStyles.body2.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Loading or Content
            SliverPadding(
              padding: EdgeInsets.all(AppSpacing.md),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  LoadingScreen(
                    loading: _isLoading,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Financial Summary
                          FinancialSummarySection(),
                          SizedBox(height: AppSpacing.lg),

                          // WhatsApp & SMS Integration Center
                          MessagingInteractionCard(),
                          SizedBox(height: AppSpacing.lg),

                          // Analytics Section
                          AnalyticsSection(),
                          SizedBox(height: AppSpacing.lg),

                          // Quick Stats Grid
                          // _buildQuickStatsGrid(),
                          // SizedBox(height: AppSpacing.lg),

                          // Properties & Occupancy
                          _buildPropertiesOccupancySection(),
                          SizedBox(height: AppSpacing.lg),

                          // Rent Timeline & Alerts
                          _buildRentTimelineSection(),
                          SizedBox(height: AppSpacing.lg),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertiesOccupancySection() {
    final properties = [
      {
        'name': 'Sunset Apartments',
        'rent': 125000,
        'occupied': 12,
        'total': 15,
      },
      {
        'name': 'Green Valley Estate',
        'rent': 98000,
        'occupied': 8,
        'total': 10,
      },
      {
        'name': 'City Center Plaza',
        'rent': 156000,
        'occupied': 10,
        'total': 12,
      },
      {'name': 'Riverside Homes', 'rent': 71000, 'occupied': 12, 'total': 11},
    ];

    return AnimatedCard(
      delay: 500,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.info.withAlpha(25),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    Icons.apartment_rounded,
                    color: AppColors.info,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Text('Properties & Occupancy', style: AppTextStyles.h6),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Occupancy Chart
            OccupancyChart(occupied: _occupiedUnits, total: _totalUnits),
            SizedBox(height: AppSpacing.lg),

            // Properties List
            ...properties.map((property) {
              return PropertyOccupancyItem(
                name: property['name'] as String,
                rent: property['rent'] as int,
                occupied: property['occupied'] as int,
                total: property['total'] as int,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRentTimelineSection() {
    final upcomingDue = [
      {
        'tenant': 'Unit 3B - John Doe',
        'amount': 25000,
        'date': 'Jan 25',
        'daysLeft': 3,
      },
      {
        'tenant': 'Unit 5A - Jane Smith',
        'amount': 28000,
        'date': 'Jan 28',
        'daysLeft': 6,
      },
      {
        'tenant': 'Unit 2C - Mike Johnson',
        'amount': 22000,
        'date': 'Jan 30',
        'daysLeft': 8,
      },
    ];

    final overdue = [
      {
        'tenant': 'Unit 1A - Sarah Wilson',
        'amount': 30000,
        'date': 'Jan 15',
        'daysOverdue': 7,
      },
      {
        'tenant': 'Unit 4D - Tom Brown',
        'amount': 26000,
        'date': 'Jan 10',
        'daysOverdue': 12,
      },
    ];

    return AnimatedCard(
      delay: 550,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    Icons.event_note_rounded,
                    color: AppColors.warning,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Text('Rent Timeline & Alerts', style: AppTextStyles.h6),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Overdue Section
            if (overdue.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withAlpha(25),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusFull,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: AppColors.error,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Overdue (${overdue.length})',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm),
              ...overdue.map((item) {
                return RentTimelineItem(
                  tenant: item['tenant'] as String,
                  amount: item['amount'] as int,
                  date: item['date'] as String,
                  status: 'overdue',
                  daysInfo: '${item['daysOverdue']} days overdue',
                );
              }),
              SizedBox(height: AppSpacing.md),
            ],

            // Upcoming Section
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.schedule, color: AppColors.info, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Upcoming (${upcomingDue.length})',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.info,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm),
            ...upcomingDue.map((item) {
              return RentTimelineItem(
                tenant: item['tenant'] as String,
                amount: item['amount'] as int,
                date: item['date'] as String,
                status: 'upcoming',
                daysInfo: 'Due in ${item['daysLeft']} days',
              );
            }),

            // Reminder Status
            SizedBox(height: AppSpacing.md),
            Container(
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 16),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'All reminders sent for upcoming payments',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
