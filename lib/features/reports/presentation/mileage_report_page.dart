import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/reports/application/report_providers.dart';
import 'package:garir_khata/features/reports/domain/report_models.dart';
import 'package:garir_khata/features/reports/presentation/widgets/simple_bar_chart.dart';

class MileageReportPage extends ConsumerWidget {
  const MileageReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(mileageReportProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.mileageReport)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (report) {
          if (report == null) {
            return Center(child: Text(l10n.selectedVehicleNone));
          }
          if (report.isEmpty) {
            return Center(child: Text(l10n.reportEmpty));
          }
          final points = report.intervals
              .where((i) => i.isAvailable && i.mileageKmPerLiter != null)
              .map(
                (i) => MonthlyPoint(
                  monthStart: DateTime.fromMillisecondsSinceEpoch(
                    i.endOdometer,
                  ),
                  value: i.mileageKmPerLiter!,
                ),
              )
              .toList();
          // Use sequential index labels via month field as refill index.
          final chartPoints = <MonthlyPoint>[];
          for (var i = 0; i < points.length; i++) {
            chartPoints.add(
              MonthlyPoint(
                monthStart: DateTime(2000, (i % 12) + 1),
                value: points[i].value,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              MetricTile(
                label: l10n.latestMileage,
                value: _fmt(report.latest, l10n.notEnoughData),
              ),
              MetricTile(
                label: l10n.mileageLast30Days,
                value: _agg(report.last30Days, l10n.notEnoughData),
              ),
              MetricTile(
                label: l10n.mileageLast90Days,
                value: _agg(report.last90Days, l10n.notEnoughData),
              ),
              MetricTile(
                label: l10n.lifetimeMileage,
                value: _agg(report.lifetime, l10n.notEnoughData),
              ),
              MetricTile(
                label: l10n.bestMileage,
                value: report.bestKmPerLiter == null
                    ? l10n.notEnoughData
                    : '${report.bestKmPerLiter!.toStringAsFixed(1)} km/L',
              ),
              MetricTile(
                label: l10n.lowestMileage,
                value: report.lowestKmPerLiter == null
                    ? l10n.notEnoughData
                    : '${report.lowestKmPerLiter!.toStringAsFixed(1)} km/L',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.mileageByRefill,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (chartPoints.isEmpty)
                Text(l10n.notEnoughData)
              else
                SimpleBarChart(
                  points: chartPoints,
                  color: AppColors.primary,
                ),
            ],
          );
        },
      ),
    );
  }

  String _fmt(MileageInterval? interval, String fallback) {
    if (interval == null || !interval.isAvailable || interval.mileageKmPerLiter == null) {
      return fallback;
    }
    return '${interval.mileageKmPerLiter!.toStringAsFixed(1)} km/L';
  }

  String _agg(MileageAggregate agg, String fallback) {
    if (!agg.isAvailable || agg.averageMileageKmPerLiter == null) {
      return fallback;
    }
    return '${agg.averageMileageKmPerLiter!.toStringAsFixed(1)} km/L';
  }
}
