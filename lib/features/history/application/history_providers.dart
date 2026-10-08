import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/history/data/repositories/drift_timeline_repository.dart';
import 'package:garir_khata/features/history/domain/repositories/timeline_repository.dart';
import 'package:garir_khata/features/history/domain/timeline_item.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

final timelineRepositoryProvider = Provider<TimelineRepository>((ref) {
  return DriftTimelineRepository(ref.watch(appDatabaseProvider));
});

class TimelineFilterNotifier extends Notifier<Set<TimelineItemType>> {
  @override
  Set<TimelineItemType> build() => TimelineItemType.values.toSet();

  void toggle(TimelineItemType type) {
    final next = Set<TimelineItemType>.of(state);
    if (next.contains(type)) {
      if (next.length > 1) {
        next.remove(type);
      }
    } else {
      next.add(type);
    }
    state = next;
  }

  void setAll() => state = TimelineItemType.values.toSet();
}

final timelineFilterProvider =
    NotifierProvider<TimelineFilterNotifier, Set<TimelineItemType>>(
  TimelineFilterNotifier.new,
);

class TimelineSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

final timelineSearchProvider =
    NotifierProvider<TimelineSearchNotifier, String>(TimelineSearchNotifier.new);

class TimelineState {
  const TimelineState({
    required this.items,
    required this.hasMore,
    required this.nextOffset,
    this.isLoadingMore = false,
  });

  final List<TimelineItem> items;
  final bool hasMore;
  final int nextOffset;
  final bool isLoadingMore;

  TimelineState copyWith({
    List<TimelineItem>? items,
    bool? hasMore,
    int? nextOffset,
    bool? isLoadingMore,
  }) {
    return TimelineState(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      nextOffset: nextOffset ?? this.nextOffset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class TimelineController extends AsyncNotifier<TimelineState> {
  static const int _pageSize = 50;

  @override
  Future<TimelineState> build() async {
    ref.watch(timelineFilterProvider);
    ref.watch(timelineSearchProvider);
    return _fetch(offset: 0, append: false);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) {
      return;
    }
    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final next = await _fetch(offset: current.nextOffset, append: true);
      state = AsyncData(next);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<TimelineState> _fetch({
    required int offset,
    required bool append,
  }) async {
    final vehicle = await ref.watch(selectedVehicleProvider.future);
    if (vehicle == null) {
      return const TimelineState(items: [], hasMore: false, nextOffset: 0);
    }
    final types = ref.read(timelineFilterProvider);
    final search = ref.read(timelineSearchProvider);
    final Result<TimelinePage> result =
        await ref.read(timelineRepositoryProvider).getPage(
              vehicleId: vehicle.id,
              limit: _pageSize,
              offset: offset,
              types: types,
              search: search.isEmpty ? null : search,
            );
    return result.when(
      success: (page) {
        final existing =
            append ? (state.value?.items ?? []) : <TimelineItem>[];
        return TimelineState(
          items: [...existing, ...page.items],
          hasMore: page.hasMore,
          nextOffset: page.nextOffset,
        );
      },
      failure: (error) => throw error,
    );
  }
}

final timelineControllerProvider =
    AsyncNotifierProvider<TimelineController, TimelineState>(
  TimelineController.new,
);
