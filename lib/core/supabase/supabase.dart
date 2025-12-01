import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService instance = SupabaseService._internal();

  factory SupabaseService() {
    return instance;
  }

  SupabaseService._internal();

  Future<void> init() async {
    // Load environment variables from env.json
    final envString = await rootBundle.loadString('env.json');
    final env = json.decode(envString) as Map<String, dynamic>;

    await Supabase.initialize(
      url: env['supabase_url'] ?? '',
      anonKey: env['supabase_anon_key'] ?? '',
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
