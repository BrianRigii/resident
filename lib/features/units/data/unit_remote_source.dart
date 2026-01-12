import 'package:resident/features/units/models/unit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UnitRemoteSource {
  Future<List<Unit>> fetchUnits();
  Future<Unit> fetchUnitById(String id);
  Future<void> createUnit(Map<String, dynamic> data);
  Future<void> updateUnit(String id, Map<String, dynamic> data);
  Future<void> deleteUnit(String id);
}

class UnitRemoteSourceImpl extends UnitRemoteSource {
  final SupabaseClient supabaseClient;
  UnitRemoteSourceImpl(this.supabaseClient);

  String get _tableName => 'units';
  @override
  Future<List<Unit>> fetchUnits() async {
    final response = await supabaseClient.from(_tableName).select();

    return response.map((data) => Unit.fromMap(data)).toList();
  }

  @override
  Future<Unit> fetchUnitById(String id) async {
    // Implement API call to fetch a unit by ID
    throw UnimplementedError();
  }

  @override
  Future<void> createUnit(Map<String, dynamic> data) async {
    await supabaseClient.from(_tableName).insert(data);
    return;
  }

  @override
  Future<void> updateUnit(String id, Map<String, dynamic> data) async {
    // Implement API call to update an existing unit
  }

  @override
  Future<void> deleteUnit(String id) async {
    // Implement API call to delete a unit
  }
}
