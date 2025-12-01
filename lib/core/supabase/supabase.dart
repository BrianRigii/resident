import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService instance = SupabaseService._internal();

  factory SupabaseService() {
    return instance;
  }

  SupabaseService._internal();

  void init() async {
    Map<String, String> env = Platform.environment;
    await Supabase.initialize(
      url: env['SUPABASE_URL'] ?? '',

      anonKey: env['SUPABASE_ANON_KEY'] ?? '',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
