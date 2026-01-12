import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resident/core/utils/uuid.dart';
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

  Map<String, dynamic> get formData {
    return {
      "id": getUUID,
      'property_id': selectedProperty?.id,
      'unit_name': _unitNameController.text,
      'rent_price': double.tryParse(_rentPriceController.text) ?? 0.0,
      'tax_rate': double.tryParse(_taxRateController.text) ?? 0.0,
      'notes': _notesController.text,
    };
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(formData);
    }
  }

  void _onPropertyChanged(Property? property) {
    setState(() {
      selectedProperty = property;
    });
  }

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyNotifier>().fetchProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Add unit form'),

            Selector<PropertyNotifier, List<Property>>(
              selector: (context, propertyNotifier) =>
                  propertyNotifier.properties,
              builder: (context, properties, _) {
                log(
                  'Building property dropdown with ${properties.length} properties',
                );
                return DropdownButtonFormField<Property>(
                  decoration: const InputDecoration(labelText: 'Property'),
                  items: properties.map((property) {
                    return DropdownMenuItem<Property>(
                      value: property,
                      child: Text(property.name),
                    );
                  }).toList(),
                  onChanged: _onPropertyChanged,
                );
              },
            ),

            TextFormField(
              controller: _unitNameController,
              decoration: const InputDecoration(
                labelText: 'Unit Name',
                hintText: 'e.g., Apt 3B',
              ),
              textInputAction: TextInputAction.next,
            ),

            TextFormField(
              controller: _rentPriceController,
              decoration: const InputDecoration(
                labelText: 'Rent Price',
                prefixText: '\$',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
            ),

            TextFormField(
              controller: _taxRateController,
              decoration: const InputDecoration(
                labelText: 'Tax Rate (%)',
                suffixText: '%',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
            ),

            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: submit, child: const Text('Add Unit')),
          ],
        ),
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
