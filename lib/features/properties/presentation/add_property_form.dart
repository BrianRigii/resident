import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:resident/core/theme/app_spacing.dart';

class AddPropertyForm extends StatefulWidget {
  static const path = '/add-property-form';
  final Function(Map<String, dynamic>) onSubmit;
  const AddPropertyForm({super.key, required this.onSubmit});

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'add_property_form');
  final TextEditingController _nameController = TextEditingController();

  Map<String, dynamic> get formData => {'name': _nameController.text};

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit.call(formData);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppSpacing.xl,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Property Name'),
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Add Property'),
          ),
        ],
      ),
    );
  }
}
