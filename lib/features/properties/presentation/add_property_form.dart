import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/utils/uuid.dart';
import 'package:resident/core/widgets/buttons.dart';

import 'package:resident/features/auth/presentation/auth_notifier.dart';
import 'package:resident/features/units/presentation/add_unit_form.dart';

class AddPropertyForm extends StatefulWidget {
  static const path = '/add-property-form';
  final Function(Map<String, dynamic>) onSubmit;
  const AddPropertyForm({super.key, required this.onSubmit});

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm>
    with SingleTickerProviderStateMixin {
  // Form state
  final _formKey = GlobalKey<FormState>(debugLabel: 'add_property_form');
  late final PageController _pageController;
  late final AnimationController _animationController;

  // Current step
  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isLandlord = true;

  // Units data
  final List<Map<String, dynamic>> _units = [];
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Map<String, dynamic> get formData {
    final AuthNotifier authNotifier = context.read<AuthNotifier>();
    return {
      "id": getUUID,
      'name': _nameController.text,
      'address': _addressController.text,
      'landLordId': _isLandlord ? [authNotifier.getAuthenticatedUser().id] : [],
      'created_by': authNotifier.getAuthenticatedUser().id,
      'units': _units,
    };
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      return _nameController.text.isNotEmpty;
    } else if (_currentStep == 1) {
      return _addressController.text.isNotEmpty;
    }
    return true;
  }

  Future<void> _nextStep() async {
    if (!_validateCurrentStep()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all required fields'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      await _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _previousStep() async {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      await _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _addUnit(Map<String, dynamic> unit) {
    setState(() {
      _units.add(unit);
    });
  }

  void _removeUnit(int index) {
    setState(() {
      _units.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      widget.onSubmit.call(formData);
      if (context.mounted) {
        context.pop();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text('Create Property', style: AppTextStyles.h5),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Progress Stepper
            _buildProgressStepper(),

            // Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentStep = page),
                children: [
                  _buildPropertyDetailsStep(),
                  _buildLocationStep(),
                  _buildUnitsStep(),
                  _buildReviewStep(),
                ],
              ),
            ),

            // Navigation Buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStepper() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          _buildStepIndicator(0, 'Details'),
          _buildStepConnector(0),
          _buildStepIndicator(1, 'Location'),
          _buildStepConnector(1),
          _buildStepIndicator(2, 'Units'),
          _buildStepConnector(2),
          _buildStepIndicator(3, 'Review'),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label) {
    final bool isActive = step == _currentStep;
    final bool isCompleted = step < _currentStep;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.primary
                  : isActive
                  ? AppColors.primary
                  : AppColors.surfaceVariant,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? AppColors.primary
                    : isCompleted
                    ? AppColors.primary
                    : AppColors.border,
                width: 2,
              ),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text(
                      '${step + 1}',
                      style: AppTextStyles.subtitle1.copyWith(
                        color: isActive || isCompleted
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isActive
                  ? AppColors.primary
                  : isCompleted
                  ? AppColors.textPrimary
                  : AppColors.textTertiary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(int step) {
    final bool isCompleted = step < _currentStep;

    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.only(bottom: 28),
        decoration: BoxDecoration(
          color: isCompleted ? AppColors.primary : AppColors.border,
        ),
      ),
    );
  }

  Widget _buildPropertyDetailsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Property Details', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Let\'s start with the basic information about your property',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xl),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Property Name *',
              hintText: 'e.g., Sunset Apartments',
              prefixIcon: Icon(Icons.business, color: AppColors.primary),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Property name is required';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.lg),
          Text('Are you the landlord/owner?', style: AppTextStyles.subtitle1),
          SizedBox(height: AppSpacing.sm),
          Text(
            'This helps us customize your experience',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          _buildLandlordToggle(),
        ],
      ),
    );
  }

  Widget _buildLandlordToggle() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        children: [
          _buildToggleOption(
            icon: Icons.person,
            title: 'Yes, I\'m the landlord',
            subtitle: 'I own and manage this property',
            value: true,
            selected: _isLandlord,
            onTap: () => setState(() => _isLandlord = true),
          ),
          Divider(height: 1, color: AppColors.border),
          _buildToggleOption(
            icon: Icons.people,
            title: 'No, I\'m a property manager',
            subtitle: 'I manage on behalf of the owner',
            value: false,
            selected: !_isLandlord,
            onTap: () => setState(() => _isLandlord = false),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withAlpha(25)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                icon,
                color: selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.subtitle1.copyWith(
                      color: selected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: selected ? 1.0 : 0.0,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, size: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Property Location', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Where is your property located?',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xl),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Full Address *',
              hintText: '123 Main Street, City, State, ZIP',
              prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
            ),
            maxLines: 3,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Address is required';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.lg),
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.info.withAlpha(51)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.info, size: 20),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'A complete address helps with tenant communications and documentation',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Property Units', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Add units to your property (optional)',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.md),
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.warning.withAlpha(51)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.warning,
                  size: 20,
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'You can skip this step and add units later',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          if (_units.isEmpty)
            _buildEmptyUnitsState()
          else
            ..._units.asMap().entries.map((entry) {
              return _buildUnitCard(entry.key, entry.value);
            }),
          SizedBox(height: AppSpacing.md),
          OutlinedButton.icon(
            onPressed: () => _showAddUnitDialog(),
            icon: Icon(Icons.add),
            label: Text(
              _units.isEmpty ? 'Add Your First Unit' : 'Add Another Unit',
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
              side: BorderSide(color: AppColors.primary, width: 2),
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyUnitsState() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.apartment, size: 32, color: AppColors.primary),
          ),
          SizedBox(height: AppSpacing.md),
          Text('No units yet', style: AppTextStyles.h6),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Add units to organize your property better',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitCard(int index, Map<String, dynamic> unit) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(Icons.meeting_room, color: AppColors.primary, size: 20),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit['name'] ?? 'Unit ${index + 1}',
                  style: AppTextStyles.subtitle1,
                ),
                if (unit['rent_price'] != null)
                  Text(
                    '\$${unit['rent_price']}/month',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.error),
            onPressed: () => _removeUnit(index),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('Review & Confirm', style: AppTextStyles.h3),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Please review your property details',
            style: AppTextStyles.body1.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.xl),
          _buildReviewCard(
            icon: Icons.business,
            title: 'Property Details',
            items: [
              _ReviewItem('Name', _nameController.text),
              _ReviewItem(
                'Owner Status',
                _isLandlord ? 'Landlord/Owner' : 'Property Manager',
              ),
            ],
            onEdit: () => _goToStep(0),
          ),
          SizedBox(height: AppSpacing.md),
          _buildReviewCard(
            icon: Icons.location_on,
            title: 'Location',
            items: [_ReviewItem('Address', _addressController.text)],
            onEdit: () => _goToStep(1),
          ),
          SizedBox(height: AppSpacing.md),
          _buildReviewCard(
            icon: Icons.apartment,
            title: 'Units',
            items: [
              _ReviewItem(
                'Total Units',
                _units.isEmpty ? 'No units added' : '${_units.length} unit(s)',
              ),
            ],
            onEdit: () => _goToStep(2),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required IconData icon,
    required String title,
    required List<_ReviewItem> items,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(icon, color: AppColors.primary, size: 20),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(child: Text(title, style: AppTextStyles.h6)),
              TextButton.icon(
                onPressed: onEdit,
                icon: Icon(Icons.edit, size: 16),
                label: Text('Edit'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          ...items.map((item) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      item.label,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(child: Text(item.value, style: AppTextStyles.body2)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _isSubmitting ? null : _previousStep,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(0, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                  child: Text('Back'),
                ),
              ),
            if (_currentStep > 0) SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: _currentStep == _totalSteps - 1
                  ? PrimaryButton(
                      text: 'Create Property',
                      onPressed: _isSubmitting ? null : _submitForm,
                      isLoading: _isSubmitting,
                      icon: Icons.check,
                    )
                  : PrimaryButton(
                      text: _currentStep == 2 ? 'Skip & Continue' : 'Continue',
                      onPressed: _isSubmitting ? null : _nextStep,
                      icon: Icons.arrow_forward,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToStep(int step) async {
    setState(() => _currentStep = step);
    await _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showAddUnitDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (context) => AddUnitForm(onSubmit: onUnitSubmit),
    );
  }

  void onUnitSubmit(Map<String, dynamic> unitData) {
    _addUnit(unitData);
  }
}

class _ReviewItem {
  final String label;
  final String value;

  _ReviewItem(this.label, this.value);
}
