// supabase_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService._(this.client);

  static Future<SupabaseService> create() async {
    final envString = await rootBundle.loadString('env.json');
    final env = json.decode(envString) as Map<String, dynamic>;

    await Supabase.initialize(
      url: env['supabase_url'] ?? '',
      anonKey: env['supabase_anon_key'] ?? '',
    );

    return SupabaseService._(Supabase.instance.client);
  }
}
