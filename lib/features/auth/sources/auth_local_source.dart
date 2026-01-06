import 'dart:async';

import 'package:hive_ce/hive.dart';
import 'package:resident/features/auth/models/user.dart';

abstract class AuthLocalSource {
  Future<void> cacheUser(User user);
  User? getCachedUser();
  Future<void> clearCache();
}

class AuthLocalSourceImpl extends AuthLocalSource {
  final Box<User> box;

  AuthLocalSourceImpl(this.box);

  @override
  Future<void> cacheUser(User user) async {
    await box.put('cached_user', user);
  }

  @override
  User? getCachedUser() {
    return box.get('cached_user');
  }

  @override
  Future<void> clearCache() async {
    await box.delete('cached_user');
  }
}
