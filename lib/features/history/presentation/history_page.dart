import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/history/application/history_providers.dart';
import 'package:garir_khata/features/history/domain/timeline_item.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final vehicle = ref.watch(selectedVehicleProvider);
    final timeline = ref.watch(timelineControllerProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );
    final dateFmt =
        DateFormat.yMMMd(Localizations.localeOf(context).toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _openFilters(context),
          ),
        ],
      ),
      body: vehicle.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (v) {
          if (v == null) {
            return Center(child: Text(l10n.selectedVehicleNone));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.xs,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.commonSearch,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              ref
                                  .read(timelineSearchProvider.notifier)
                                  .setQuery('');
                            },
                          ),
                  ),
                  onChanged: (value) => ref
                      .read(timelineSearchProvider.notifier)
                      .setQuery(value),
                ),
              ),
              Expanded(
                child: timeline.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => Center(child: Text(l10n.commonError)),
                  data: (state) {
                    if (state.items.isEmpty) {
                      return Center(child: Text(l10n.historyEmpty));
                    }
                    return NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n.metrics.pixels >=
                                n.metrics.maxScrollExtent - 120 &&
                            state.hasMore &&
                            !state.isLoadingMore) {
                          ref
                              .read(timelineControllerProvider.notifier)
                              .loadMore();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        itemCount:
                            state.items.length + (state.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            return const Padding(
                              padding: EdgeInsets.all(AppSpacing.md),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final item = state.items[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    _color(item.type).withValues(alpha: 0.15),
                                child: Icon(
                                  _icon(item.type),
                                  color: _color(item.type),
                                  size: 20,
                                ),
                              ),
                              title: Text(item.title),
                              subtitle: Text(
                                [
                                  dateFmt.format(item.occurredAt),
                                  if (item.odometer != null)
                                    '${item.odometer} km',
                                  if (item.subtitle != null &&
                                      item.subtitle!.isNotEmpty)
                                    item.subtitle!,
                                ].join(' · '),
                              ),
                              trailing: item.amountPaisa == null
                                  ? null
                                  : Text(
                                      currency.formatPaisa(item.amountPaisa!),
                                    ),
                              onTap: () => context.push(item.routePath),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openFilters(BuildContext context) async {
    final l10n = context.l10n;
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return Consumer(
          builder: (context, ref, _) {
            final selected = ref.watch(timelineFilterProvider);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.historyFilters,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.xs,
                      children: TimelineItemType.values.map((type) {
                        final on = selected.contains(type);
                        return FilterChip(
                          label: Text(_typeLabel(l10n, type)),
                          selected: on,
                          onSelected: (_) => ref
                              .read(timelineFilterProvider.notifier)
                              .toggle(type),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            ref.read(timelineFilterProvider.notifier).setAll();
                            Navigator.pop(sheetContext);
                          },
                          child: Text(l10n.commonClear),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () => Navigator.pop(sheetContext),
                          child: Text(l10n.commonApply),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  IconData _icon(TimelineItemType type) => switch (type) {
        TimelineItemType.fuel => Icons.local_gas_station_outlined,
        TimelineItemType.expense => Icons.payments_outlined,
        TimelineItemType.service => Icons.build_outlined,
        TimelineItemType.repair => Icons.handyman_outlined,
        TimelineItemType.oil => Icons.water_drop_outlined,
        TimelineItemType.tyre => Icons.trip_origin,
        TimelineItemType.battery => Icons.battery_charging_full_outlined,
        TimelineItemType.document => Icons.description_outlined,
        TimelineItemType.odometer => Icons.speed_outlined,
      };

  Color _color(TimelineItemType type) => switch (type) {
        TimelineItemType.fuel => AppColors.fuel,
        TimelineItemType.expense => AppColors.other,
        TimelineItemType.service => AppColors.maintenance,
        TimelineItemType.repair => AppColors.repair,
        TimelineItemType.oil => AppColors.maintenance,
        TimelineItemType.tyre => AppColors.other,
        TimelineItemType.battery => AppColors.warning,
        TimelineItemType.document => AppColors.other,
        TimelineItemType.odometer => AppColors.textSecondary,
      };

  String _typeLabel(AppLocalizations l10n, TimelineItemType type) =>
      switch (type) {
        TimelineItemType.fuel => l10n.fuel,
        TimelineItemType.expense => l10n.expense,
        TimelineItemType.service => l10n.service,
        TimelineItemType.repair => l10n.repairs,
        TimelineItemType.oil => l10n.oil,
        TimelineItemType.tyre => l10n.tyres,
        TimelineItemType.battery => l10n.batteryTitle,
        TimelineItemType.document => l10n.documents,
        TimelineItemType.odometer => l10n.odometer,
      };
}
