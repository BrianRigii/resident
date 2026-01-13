import 'package:resident/features/auth/sources/auth_remote_source.dart';
import 'package:resident/features/auth/models/user.dart';
import 'package:resident/features/auth/sources/auth_local_source.dart';

abstract class AuthService {
  Future<User> signIn(Map<String, dynamic> data);
  Future<User> signUp(Map<String, dynamic> data);
  void logOut();
}

class AuthServiceImpl extends AuthService {
  final AuthRemoteSource authRemoteSource;
  final AuthLocalSource authLocalSource;

  AuthServiceImpl(this.authRemoteSource, this.authLocalSource);

  @override
  Future<User> signIn(Map<String, dynamic> data) async {
    try {
      User user = await authRemoteSource.signIn(data);
      authLocalSource.cacheUser(user);

      return user;
    } catch (e) {
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
      User user = await authRemoteSource.signUp(data);
      authLocalSource.cacheUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
