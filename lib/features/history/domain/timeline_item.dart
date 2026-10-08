enum TimelineItemType {
  fuel,
  expense,
  service,
  repair,
  oil,
  tyre,
  battery,
  document,
  odometer,
}

class TimelineItem {
  const TimelineItem({
    required this.id,
    required this.vehicleId,
    required this.type,
    required this.occurredAt,
    required this.title,
    required this.routePath,
    this.subtitle,
    this.amountPaisa,
    this.odometer,
    this.searchText,
  });

  final String id;
  final String vehicleId;
  final TimelineItemType type;
  final DateTime occurredAt;
  final String title;
  final String? subtitle;
  final int? amountPaisa;
  final int? odometer;
  final String routePath;
  final String? searchText;

  static TimelineItemType? parseType(String raw) {
    return switch (raw) {
      'fuel' => TimelineItemType.fuel,
      'expense' => TimelineItemType.expense,
      'service' => TimelineItemType.service,
      'repair' => TimelineItemType.repair,
      'oil' => TimelineItemType.oil,
      'tyre' => TimelineItemType.tyre,
      'battery' => TimelineItemType.battery,
      'document' => TimelineItemType.document,
      'odometer' => TimelineItemType.odometer,
      _ => null,
    };
  }

  static String typeCode(TimelineItemType type) => type.name;
}

class TimelinePage {
  const TimelinePage({
    required this.items,
    required this.hasMore,
    required this.nextOffset,
  });

  final List<TimelineItem> items;
  final bool hasMore;
  final int nextOffset;
}
