import 'package:flutter/material.dart';
import 'package:resident/core/utils/uuid.dart';
import 'package:resident/features/properties/models/property.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Add unit form'),

          TextFormField(
            controller: _unitNameController,
            decoration: const InputDecoration(
              labelText: 'Unit Name',
              hintText: 'e.g., Apt 3B',
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),

          TextFormField(
            controller: _rentPriceController,
            decoration: const InputDecoration(
              labelText: 'Rent Price',
              prefixText: '\$',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),

          TextFormField(
            controller: _taxRateController,
            decoration: const InputDecoration(
              labelText: 'Tax Rate (%)',
              suffixText: '%',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),

          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notes'),
            maxLines: 3,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: submit, child: const Text('Add Unit')),
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
