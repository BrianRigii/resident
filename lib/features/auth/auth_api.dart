import 'dart:developer';

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
    final response = await supabaseClient.auth.signInWithPassword(
      email: data['email'],
      password: data['password'],
    );

    if (response.session == null || response.user == null) {
      throw Exception('Authentication failed');
    }

    final supabaseUser = response.user!;
    return User(
      id: supabaseUser.id,
      email: supabaseUser.email ?? '',
      name: supabaseUser.userMetadata?['full_name'] ?? '',
      createdAt: DateTime.parse(supabaseUser.createdAt),
    );
  }

  @override
  Future<User> signUp(Map<String, dynamic> data) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: data['email'],
        password: data['password'],
      );

      if (response.user == null) {
        throw Exception('Sign up failed');
      }

      final supabaseUser = response.user!;
      return User(
        id: supabaseUser.id,
        email: supabaseUser.email ?? '',
        name: supabaseUser.userMetadata?['full_name'] ?? '',
        createdAt: DateTime.parse(supabaseUser.createdAt),
      );
    } catch (e) {
      log('Error during sign up: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {}
}
