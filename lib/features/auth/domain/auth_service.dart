import 'package:flutter/widgets.dart';
import 'package:resident/features/auth/auth_api.dart';
import 'package:resident/features/auth/models/user.dart';

abstract class AuthService extends ChangeNotifier {
  bool get isAuthenticating;
  User? get currentUser;
  Future<User> signIn(Map<String, dynamic> data);
  Future<User> signUp(Map<String, dynamic> data);
  void logOut();
}

class AuthServiceImpl extends AuthService {
  final AuthApi authApi;
  AuthServiceImpl(this.authApi);

  bool _isAuthenticating = false;
  @override
  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating(bool val) {
    _isAuthenticating = val;
    notifyListeners();
  }

  User? _currentUser;
  @override
  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  @override
  Future<User> signIn(Map<String, dynamic> data) async {
    try {
      isAuthenticating = true;
      User user = await authApi.signIn(data);
      currentUser = user;
      isAuthenticating = false;
      return user;
    } catch (e) {
      isAuthenticating = false;
      rethrow;
    }
  }

  @override
  void logOut() {
    currentUser = null;
  }

  @override
  Future<User> signUp(Map<String, dynamic> data) async {
    try {
      isAuthenticating = true;
      User user = await authApi.signUp(data);
      currentUser = user;
      isAuthenticating = false;
      return user;
    } catch (e) {
      isAuthenticating = false;
      rethrow;
    }
  }
}
