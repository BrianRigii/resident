import 'package:resident/features/units/data/unit_remote_source.dart';
import 'package:resident/features/units/models/unit.dart';

abstract class UnitService {
  Future<List<Unit>> getUnits();
  Future<Unit> getUnitById(String id);
  Future<void> addUnit(Map<String, dynamic> data);
  Future<void> editUnit(String id, Map<String, dynamic> data);
  Future<void> removeUnit(String id);
}

class UnitServiceImpl extends UnitService {
  final UnitRemoteSource unitApi;
  UnitServiceImpl(this.unitApi);

  @override
  Future<List<Unit>> getUnits() async {
    try {
      List<Unit> units = await unitApi.fetchUnits();

      return units;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> getUnitById(String id) async {
    return await unitApi.fetchUnitById(id);
  }

  @override
  Future<void> addUnit(Map<String, dynamic> data) async {
    await unitApi.createUnit(data);
  }

  @override
  Future<void> editUnit(String id, Map<String, dynamic> data) async {
    await unitApi.updateUnit(id, data);
  }

  @override
  Future<void> removeUnit(String id) async {
    await unitApi.deleteUnit(id);
  }
}
