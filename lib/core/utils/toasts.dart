import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast(BuildContext context, String title, String message) {
  toastification.show(
    context: context,
    title: Text(title),
    description: Text(message),
    autoCloseDuration: const Duration(seconds: 3),
  );
}
