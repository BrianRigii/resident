import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/widgets/add_selection_widget.dart';
import 'package:resident/core/widgets/modern_stats_card.dart';
import 'package:resident/home_screen_widgets.dart';

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

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  bool _isLoading = true;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Mock data
  final double _totalRentDue = 450000; // KES
  final double _totalRentCollected = 385000; // KES
  final int _totalProperties = 12;
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
          elevation: 0,
          child: const Icon(Icons.add, size: 28),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.surfaceGradient),
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            _buildAppBar(),

            // Loading or Content
            if (_isLoading)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: AppColors.primary),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        'Loading dashboard...',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Financial Summary
                          _buildFinancialSummarySection(),
                          SizedBox(height: AppSpacing.lg),

                          // WhatsApp & SMS Integration Center
                          _buildMessagingIntegrationCard(),
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

                          // Analytics Section
                          _buildAnalyticsSection(),
                          SizedBox(height: AppSpacing.xxxl),
                        ],
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

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: MediaQuery.sizeOf(context).height * 0.1,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
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
                          'Welcome back, Alex! 👋',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton.outlined(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagingIntegrationCard() {
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

  Widget _buildFinancialSummarySection() {
    final outstanding = _totalRentDue - _totalRentCollected;
    final collectionRate = (_totalRentCollected / _totalRentDue * 100);

    return AnimatedCard(
      delay: 200,
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
                    color: Theme.of(context).colorScheme.primary.withAlpha(25),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Text('Financial Summary', style: AppTextStyles.h6),
                Spacer(),
                Text(
                  'January 2026',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Rent Collected vs Due
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Due',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'KES ${_formatCurrency(_totalRentDue)}',
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: AppColors.border),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Collected',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'KES ${_formatCurrency(_totalRentCollected)}',
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.md),

            // Outstanding Balance
            Container(
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.pending_actions,
                    color: AppColors.warning,
                    size: 16,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    'Outstanding: ',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                  Text(
                    'KES ${_formatCurrency(outstanding)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Collection Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Collection Progress',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${collectionRate.toStringAsFixed(1)}%',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xs),
                AnimatedProgressBar(
                  progress: collectionRate / 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.1,
      children: [
        AnimatedCard(
          delay: 300,
          child: ModernStatsCard(
            title: 'Total Properties',
            value: '$_totalProperties',
            icon: Icons.apartment_rounded,
            gradient: AppColors.primaryGradient,
            trend: '+2',
            trendPositive: true,
          ),
        ),
        AnimatedCard(
          delay: 350,
          child: ModernStatsCard(
            title: 'Total Units',
            value: '$_totalUnits',
            icon: Icons.meeting_room_rounded,
            gradient: AppColors.primaryGradient,
            trend: '+5',
            trendPositive: true,
          ),
        ),
        AnimatedCard(
          delay: 400,
          child: ModernStatsCard(
            title: 'Occupied',
            value: '$_occupiedUnits',
            icon: Icons.check_circle_rounded,
            gradient: AppColors.primaryGradient,
            trend:
                '${(_occupiedUnits / _totalUnits * 100).toStringAsFixed(1)}%',
          ),
        ),
        AnimatedCard(
          delay: 450,
          child: ModernStatsCard(
            title: 'Vacant',
            value: '${_totalUnits - _occupiedUnits}',
            icon: Icons.info_rounded,
            gradient: AppColors.primaryGradient,
            trend:
                '${((_totalUnits - _occupiedUnits) / _totalUnits * 100).toStringAsFixed(1)}%',
          ),
        ),
      ],
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
                    color: AppColors.info.withOpacity(0.1),
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
                      color: AppColors.error.withOpacity(0.1),
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

  Widget _buildAnalyticsSection() {
    final topDefaulters = [
      {'name': 'Unit 1A - Sarah Wilson', 'amount': 30000, 'months': 1},
      {'name': 'Unit 4D - Tom Brown', 'amount': 26000, 'months': 1},
      {'name': 'Unit 7B - Lisa Anderson', 'amount': 52000, 'months': 2},
    ];

    return AnimatedCard(
      delay: 600,
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
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    Icons.analytics_rounded,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Text('Analytics', style: AppTextStyles.h6),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Collection Trend Chart
            Text(
              'Collection Trend (Last 6 Months)',
              style: AppTextStyles.subtitle2,
            ),
            SizedBox(height: AppSpacing.sm),
            CollectionTrendChart(),
            SizedBox(height: AppSpacing.lg),

            // Average Days to Pay
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer, color: AppColors.info, size: 16),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              'Avg Days to Pay',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.info,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          '5.2 days',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: AppColors.success,
                              size: 16,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text(
                              'On-Time Rate',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.xs),
                        Text(
                          '87.5%',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.lg),

            // Top Defaulters
            Text('Top Defaulters', style: AppTextStyles.subtitle2),
            SizedBox(height: AppSpacing.sm),
            ...topDefaulters.map((defaulter) {
              return DefaulterItem(
                name: defaulter['name'] as String,
                amount: defaulter['amount'] as int,
                months: defaulter['months'] as int,
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return amount
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
