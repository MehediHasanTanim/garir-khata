import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/parts/domain/entities/tyre.dart';

abstract interface class TyreRepository {
  Future<Result<List<Tyre>>> getActive(String vehicleId);
  Future<Result<List<Tyre>>> getHistory(String vehicleId);
  Future<Result<Tyre?>> getById(String id);
  Future<Result<Tyre>> create(Tyre tyre, {TyreEvent? installEvent});
  Future<Result<Tyre>> update(Tyre tyre);
  Future<Result<TyreEvent>> addEvent(TyreEvent event);
  Future<Result<Tyre>> replace({
    required Tyre oldTyre,
    required Tyre newTyre,
    required TyreEvent removeEvent,
    required TyreEvent installEvent,
  });
  Future<Result<void>> delete(String id);
}
