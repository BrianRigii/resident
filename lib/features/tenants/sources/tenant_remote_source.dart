import 'package:resident/features/tenants/models/tenant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TenantRemoteSource {
  Future<void> addTenant(Map<String, dynamic> tenantData);
  Future<List<Tenant>> getTenants();
}

class TenantRemoteSourceImpl implements TenantRemoteSource {
  final SupabaseClient supabaseClient;
  TenantRemoteSourceImpl(this.supabaseClient);

  String get _tableName => 'tenants';

  @override
  Future<void> addTenant(Map<String, dynamic> tenantData) async {
    await supabaseClient.from(_tableName).insert(tenantData);
  }

  @override
  Future<List<Tenant>> getTenants() async {
    // Implementation for fetching tenants remotely
    // This is a placeholder implementation
    return [];
  }
}
