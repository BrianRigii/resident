import 'package:flutter/widgets.dart';
import 'package:resident/features/auth/sources/auth_remote_source.dart';
import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/sources/auth_local_source.dart';

abstract class AuthService extends ChangeNotifier {
  bool get isAuthenticating;
  User? get currentUser;
  Future<User> signIn(Map<String, dynamic> data);
  Future<User> signUp(Map<String, dynamic> data);
  void logOut();
}

class AuthServiceImpl extends AuthService {
  final AuthRemoteSource authApi;
  final AuthLocalSource authLocalSource;

  AuthServiceImpl(this.authApi, this.authLocalSource);

  bool _isAuthenticating = false;
  @override
  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating(bool val) {
    _isAuthenticating = val;
    notifyListeners();
  }

  @override
  User? get currentUser => authLocalSource.getCachedUser();

  @override
  Future<User> signIn(Map<String, dynamic> data) async {
    try {
      isAuthenticating = true;
      User user = await authApi.signIn(data);
      authLocalSource.cacheUser(user);
      isAuthenticating = false;
      return user;
    } catch (e) {
      isAuthenticating = false;
      rethrow;
    }
  }

  @override
  void logOut() {
    authLocalSource.clearCache();
  }

  @override
  Future<User> signUp(Map<String, dynamic> data) async {
    try {
      isAuthenticating = true;
      User user = await authApi.signUp(data);
      authLocalSource.cacheUser(user);
      isAuthenticating = false;
      return user;
    } catch (e) {
      isAuthenticating = false;
      rethrow;
    }
  }
}
