import 'package:flutter/material.dart';
import 'package:resident/features/auth/models/user.dart';

import '../domain/auth_service.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthService authService;
  bool _isAuthenticating = false;

  AuthNotifier({required this.authService});

  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating(bool val) {
    _isAuthenticating = val;
    notifyListeners();
  }

  User? currentUser;

  Future signIn(Map<String, dynamic> data) async {
    isAuthenticating = true;
    try {
      User user = await authService.signIn(data);
      currentUser = user;
      isAuthenticating = false;
      notifyListeners();
    } catch (e) {
      isAuthenticating = false;
      rethrow;
    }
  }

  User getAuthenticatedUser() {
    if (_isAuthenticating) {
      throw Exception('Authentication in progress');
    }
    if (currentUser == null) {
      throw Exception('No authenticated user found');
    }
    return currentUser!;
  }
}
