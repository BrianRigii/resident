import 'package:flutter/material.dart';

class AddUnitForm extends StatefulWidget {
  const AddUnitForm({super.key});

  @override
  State<AddUnitForm> createState() => _AddUnitFormState();
}

class _AddUnitFormState extends State<AddUnitForm> {
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _rentPriceController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
