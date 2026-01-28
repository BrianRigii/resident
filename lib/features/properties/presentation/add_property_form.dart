import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/utils/uuid.dart';
import 'package:resident/core/widgets/buttons.dart';
import 'package:resident/core/widgets/progress_stepper.dart';

import 'package:resident/features/auth/presentation/auth_notifier.dart';
import 'package:resident/features/properties/presentation/add_location_section_form.dart';
import 'package:resident/features/properties/presentation/add_property_detail_section_form.dart';
import 'package:resident/features/properties/presentation/add_property_notifier.dart';
import 'package:resident/features/properties/presentation/add_property_review_section.dart';
import 'package:resident/features/properties/presentation/add_units_section_form.dart';

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

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final bool _isLandlord = true;

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
      body: ChangeNotifierProvider(
        create: (_) => AddPropertyNotifier(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Progress Stepper
              ProgressStepper(),

              // Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: context.read<AddPropertyNotifier>().setStep,
                  children: [
                    AddPropertyDetailSectionForm(
                      nameController: _nameController,
                    ),
                    AddLocationSectionForm(
                      addressController: _addressController,
                    ),
                    AddUnitsSectionForm(),
                    AddPropertyReviewSection(
                      nameController: _nameController,
                      addressController: _addressController,
                    ),
                  ],
                ),
              ),

              // Navigation Buttons
              Container(
                padding: EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    top: BorderSide(color: AppColors.border, width: 1),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      if (context.read<AddPropertyNotifier>().currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isSubmitting
                                ? null
                                : context
                                      .read<AddPropertyNotifier>()
                                      .previousStep,
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(0, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
                              ),
                            ),
                            child: Text('Back'),
                          ),
                        ),
                      if (context.read<AddPropertyNotifier>().currentStep > 0)
                        SizedBox(width: AppSpacing.md),
                      Expanded(
                        flex: 2,
                        child:
                            context.read<AddPropertyNotifier>().currentStep == 3
                            ? PrimaryButton(
                                text: 'Create Property',
                                onPressed: _isSubmitting ? null : _submitForm,
                                isLoading: _isSubmitting,
                                icon: Icons.check,
                              )
                            : PrimaryButton(
                                text:
                                    context
                                            .read<AddPropertyNotifier>()
                                            .currentStep ==
                                        2
                                    ? 'Skip & Continue'
                                    : 'Continue',
                                onPressed: _isSubmitting
                                    ? null
                                    : context
                                          .read<AddPropertyNotifier>()
                                          .nextStep,
                                icon: Icons.arrow_forward,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
