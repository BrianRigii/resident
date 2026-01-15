import 'package:resident/core/utils/fetch_strategy.dart';
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
  final UnitRemoteSource unitRemoteSource;
  UnitServiceImpl(this.unitRemoteSource);

  @override
  Future<List<Unit>> getUnits() async {
    try {
      List<Unit> units = await unitRemoteSource.fetchUnits();

      return units;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> getUnitById(String id) async {
    return await unitRemoteSource.fetchUnitById(id);
  }

  @override
  Future<void> addUnit(Map<String, dynamic> data) async {
    await unitRemoteSource.createUnit(data);
  }

  @override
  Future<void> editUnit(String id, Map<String, dynamic> data) async {
    await unitRemoteSource.updateUnit(id, data);
  }

  @override
  Future<void> removeUnit(String id) async {
    await unitRemoteSource.deleteUnit(id);
  }
}
