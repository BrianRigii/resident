import 'package:resident/features/properties/models/property.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PropertApi {
  Future<List<Property>> fetchProperties();
  Future<Property> fetchPropertyById(String id);
  Future<void> createProperty(Map<String, dynamic> data);
  Future<void> updateProperty(String id, Map<String, dynamic> data);
  Future<void> deleteProperty(String id);
}

class PropertApiImpl extends PropertApi {
  final SupabaseClient supabaseClient;
  String get _propertiesTable => 'properties';
  PropertApiImpl(this.supabaseClient);

  @override
  Future<List<Property>> fetchProperties() async {
    final response = await supabaseClient.from(_propertiesTable).select();
    return (response as List).map((item) {
      return Property(
        id: item['id'],
        name: item['name'],
        address: item['address'],

        landLordId: item['landLordId'],
      );
    }).toList();
  }

  @override
  Future<Property> fetchPropertyById(String id) async {
    final response = await supabaseClient
        .from(_propertiesTable)
        .select()
        .eq('id', id)
        .single();
    return Property(
      id: response['id'],
      name: response['name'],
      address: response['address'],
      landLordId: response['landLordId'],
    );
  }

  @override
  Future<void> createProperty(Map<String, dynamic> data) async {
    await supabaseClient.from(_propertiesTable).insert(data);
    return;
  }

  @override
  Future<void> updateProperty(String id, Map<String, dynamic> data) async {
    await supabaseClient.from(_propertiesTable).update(data).eq('id', id);
    return;
  }

  @override
  Future<void> deleteProperty(String id) async {
    await supabaseClient.from(_propertiesTable).delete().eq('id', id);
    return;
  }
}
