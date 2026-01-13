import 'package:flutter/material.dart';
import 'package:resident/features/properties/models/property.dart';
import 'package:resident/features/units/models/unit.dart';

class AddTenantForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  const AddTenantForm({super.key, required this.onSubmit});

  @override
  State<AddTenantForm> createState() => _AddTenantFormState();
}

class _AddTenantFormState extends State<AddTenantForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  DateTime? moveInDate;
  Unit? selectedUnit;
  Property? selectedProperty;

  @override
  void dispose() {
    nameController.dispose();
    depositController.dispose();
    phoneNumberController.dispose();
    emailAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          ),
          TextFormField(
            controller: phoneNumberController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
          ),
          TextFormField(
            controller: emailAddressController,
            decoration: const InputDecoration(labelText: 'Email Address'),
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: depositController,
            decoration: const InputDecoration(labelText: 'Deposit'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
