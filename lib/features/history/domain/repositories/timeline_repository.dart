import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/history/domain/timeline_item.dart';

abstract interface class TimelineRepository {
  Future<Result<TimelinePage>> getPage({
    required String vehicleId,
    int limit = 50,
    int offset = 0,
    Set<TimelineItemType>? types,
    String? search,
  });
}
