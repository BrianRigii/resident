import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool loading;
  final Widget child;
  const LoadingScreen({super.key, required this.loading, required this.child});

  @override
  Widget build(BuildContext context) {
    return loading ? const Center(child: CircularProgressIndicator()) : child;
  }
}
