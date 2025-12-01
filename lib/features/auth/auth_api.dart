import 'package:resident/features/auth/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

abstract class AuthApi {
  Future<User> signIn(Map<String, dynamic> data);

  Future<User> signUp(Map<String, dynamic> data);

  Future<void> signOut();
}

class AuthApiImpl extends AuthApi {
  final SupabaseClient supabaseClient;
  AuthApiImpl(this.supabaseClient);

  @override
  Future<User> signIn(Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  @override
  Future<User> signUp(Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {}
}
