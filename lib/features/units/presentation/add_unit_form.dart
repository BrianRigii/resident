import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';
import 'package:resident/core/utils/uuid.dart';
import 'package:resident/core/widgets/buttons.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/properties/presentation/property_notifier.dart';

class AddUnitForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  const AddUnitForm({super.key, required this.onSubmit});

  @override
  State<AddUnitForm> createState() => _AddUnitFormState();
}

class _AddUnitFormState extends State<AddUnitForm> {
  Property? selectedProperty;
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _rentPriceController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  Map<String, dynamic> get formData {
    return {
      "id": getUUID,
      'property_id': selectedProperty?.id,
      'name': _unitNameController.text,
      'rent_price': double.tryParse(_rentPriceController.text) ?? 0.0,
      'tax_rate': double.tryParse(_taxRateController.text) ?? 0.0,
      'notes': _notesController.text,
    };
  }

  Future<void> submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);
      try {
        widget.onSubmit(formData);
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
    }
  }

  void _onPropertyChanged(Property? property) {
    setState(() {
      selectedProperty = property;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyNotifier>().fetchProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyNotifier = context.watch<PropertyNotifier>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF3B82F6).withAlpha(77),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.meeting_room_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add Unit', style: AppTextStyles.h5),
                      SizedBox(height: 2),
                      Text(
                        'Create a new unit for your property',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Divider(height: AppSpacing.lg, color: AppColors.border),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Property Selection
                    DropdownButtonFormField<Property>(
                      initialValue: selectedProperty,
                      decoration: InputDecoration(
                        labelText: 'Property *',
                        hintText: 'Select a property',
                        prefixIcon: Icon(
                          Icons.apartment_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      items: propertyNotifier.properties.map((property) {
                        return DropdownMenuItem<Property>(
                          value: property,
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(25),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusSm,
                                  ),
                                ),
                                child: Icon(
                                  Icons.business_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      property.name,
                                      style: AppTextStyles.body2.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (property.address.isNotEmpty)
                                      Text(
                                        property.address,
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: _onPropertyChanged,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a property';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Unit Details Section
                    Text(
                      'Unit Details',
                      style: AppTextStyles.h6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    TextFormField(
                      controller: _unitNameController,
                      decoration: InputDecoration(
                        labelText: 'Unit Name *',
                        hintText: 'e.g., Apt 3B',
                        prefixIcon: Icon(
                          Icons.door_front_door_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Unit name is required';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSpacing.md),

                    // Pricing Section
                    Text(
                      'Pricing',
                      style: AppTextStyles.h6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    TextFormField(
                      controller: _rentPriceController,
                      decoration: InputDecoration(
                        labelText: 'Monthly Rent',
                        hintText: '0.00',
                        prefixText: '\$ ',
                        prefixIcon: Icon(
                          Icons.attach_money_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                    ),

                    SizedBox(height: AppSpacing.md),

                    TextFormField(
                      controller: _taxRateController,
                      decoration: InputDecoration(
                        labelText: 'Tax Rate',
                        hintText: '0.00',
                        suffixText: '%',
                        prefixIcon: Icon(
                          Icons.percent_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Additional Info Section
                    Text(
                      'Additional Information',
                      style: AppTextStyles.h6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.md),

                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: 'Notes',
                        hintText: 'Add any additional details...',
                        prefixIcon: Icon(
                          Icons.notes_rounded,
                          color: AppColors.primary,
                        ),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                      textInputAction: TextInputAction.done,
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Info Box
                    Container(
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.info.withAlpha(25),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                        border: Border.all(color: AppColors.info.withAlpha(51)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.info,
                            size: 20,
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'You can always edit these details later from the unit management page',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.info,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Action Buttons
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
              child: PrimaryButton(
                text: 'Add Unit',
                icon: Icons.add_rounded,
                onPressed: _isSubmitting ? null : submit,
                isLoading: _isSubmitting,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _unitNameController.dispose();
    _rentPriceController.dispose();
    _taxRateController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
