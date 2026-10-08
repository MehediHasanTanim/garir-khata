import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/formatting/currency_formatter.dart';
import 'package:garir_khata/features/dashboard/application/dashboard_providers.dart';
import 'package:garir_khata/features/dashboard/domain/dashboard_summary.dart';
import 'package:garir_khata/features/maintenance/application/maintenance_providers.dart';
import 'package:garir_khata/features/maintenance/domain/entities/service_record.dart';
import 'package:garir_khata/features/mileage/domain/cost_per_km_calculator.dart';
import 'package:garir_khata/features/mileage/domain/mileage_result.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';
import 'package:garir_khata/features/vehicles/domain/entities/vehicle.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_switcher_sheet.dart';
import 'package:garir_khata/features/vehicles/presentation/widgets/vehicle_type_icon.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final summaryAsync = ref.watch(dashboardSummaryProvider);
    final selectedVehicle = ref.watch(selectedVehicleProvider);
    final currency = CurrencyFormatter(
      locale: Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          IconButton(
            tooltip: l10n.remindersTitle,
            onPressed: () => context.push('/reminders'),
            icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
      body: summaryAsync.when(
        loading: () => selectedVehicle.when(
          data: (vehicle) => vehicle == null
              ? Center(child: Text(l10n.selectedVehicleNone))
              : const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(l10n.commonError)),
        ),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (summary) {
          if (summary == null) {
            return Center(child: Text(l10n.selectedVehicleNone));
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(dashboardSummaryProvider);
              await ref.read(dashboardSummaryProvider.future);
            },
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                _VehicleHeader(vehicle: summary.vehicle),
                const SizedBox(height: AppSpacing.md),
                _OdometerCard(odometer: summary.currentOdometer, l10n: l10n),
                const SizedBox(height: AppSpacing.md),
                if (!summary.hasAnyData)
                  _EmptyDashboard(l10n: l10n)
                else ...[
                  _ThisMonthCard(
                    summary: summary,
                    currency: currency,
                    l10n: l10n,
                    onPrevMonth: () =>
                        ref.read(dashboardMonthProvider.notifier).previousMonth(),
                    onNextMonth: () =>
                        ref.read(dashboardMonthProvider.notifier).nextMonth(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _DrivingSummaryCard(
                    summary: summary,
                    currency: currency,
                    l10n: l10n,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _UpcomingSection(l10n: l10n),
                  const SizedBox(height: AppSpacing.md),
                  _QuickActions(l10n: l10n),
                  const SizedBox(height: AppSpacing.md),
                  _RecentActivity(
                    items: summary.recentActivity,
                    currency: currency,
                    l10n: l10n,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _VehicleHeader extends ConsumerWidget {
  const _VehicleHeader({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        onTap: () => showVehicleSwitcher(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              VehicleTypeBadge(
                type: vehicle.vehicleType,
                selected: true,
                size: 52,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            vehicle.nickname,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    if (vehicle.displaySubtitle.isNotEmpty)
                      Text(vehicle.displaySubtitle),
                    if (vehicle.registrationNumber != null)
                      Text(
                        vehicle.registrationNumber!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OdometerCard extends StatelessWidget {
  const _OdometerCard({required this.odometer, required this.l10n});

  final int odometer;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final NumberFormat number = NumberFormat.decimalPattern();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0x1A0D7A70),
              child: Icon(Icons.speed, color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${number.format(odometer)} km',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(l10n.currentOdometer),
                ],
              ),
            ),
            TextButton(
              onPressed: () => context.push('/odometer/update'),
              child: Text(l10n.updateOdometer),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDashboard extends StatelessWidget {
  const _EmptyDashboard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Text(
              l10n.dashboardEmptyTitle,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.dashboardEmptyHint, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => context.push('/fuel/add'),
              child: Text(l10n.addFuel),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => context.push('/expenses/add'),
              child: Text(l10n.addExpense),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThisMonthCard extends StatelessWidget {
  const _ThisMonthCard({
    required this.summary,
    required this.currency,
    required this.l10n,
    required this.onPrevMonth,
    required this.onNextMonth,
  });

  final DashboardSummary summary;
  final CurrencyFormatter currency;
  final AppLocalizations l10n;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;

  @override
  Widget build(BuildContext context) {
    final String monthLabel =
        DateFormat.yMMMM(Localizations.localeOf(context).toString())
            .format(summary.monthStart);
    final breakdown = summary.expenses;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.thisMonthExpenses,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onPrevMonth,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(monthLabel),
                IconButton(
                  onPressed: onNextMonth,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _ExpenseTile(
                    label: l10n.fuel,
                    amount: currency.formatPaisa(breakdown.fuelPaisa),
                    color: AppColors.fuel,
                    icon: Icons.local_gas_station,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _ExpenseTile(
                    label: l10n.maintenance,
                    amount: currency.formatPaisa(breakdown.maintenancePaisa),
                    color: AppColors.maintenance,
                    icon: Icons.build_circle_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _ExpenseTile(
                    label: l10n.repairs,
                    amount: currency.formatPaisa(breakdown.repairPaisa),
                    color: AppColors.repair,
                    icon: Icons.handyman_outlined,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _ExpenseTile(
                    label: l10n.other,
                    amount: currency.formatPaisa(breakdown.otherPaisa),
                    color: AppColors.other,
                    icon: Icons.more_horiz,
                  ),
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined,
                    color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.totalExpense),
                const Spacer(),
                Text(
                  currency.formatPaisa(breakdown.totalPaisa),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  final String label;
  final String amount;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          Text(amount, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}

class _DrivingSummaryCard extends StatelessWidget {
  const _DrivingSummaryCard({
    required this.summary,
    required this.currency,
    required this.l10n,
  });

  final DashboardSummary summary;
  final CurrencyFormatter currency;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final MileageAggregate mileage = summary.mileage;
    final CostPerKmResult cost = summary.costPerKm;
    final NumberFormat number = NumberFormat.decimalPattern();

    String mileageLabel = l10n.notEnoughData;
    if (mileage.isAvailable && mileage.averageMileageKmPerLiter != null) {
      mileageLabel =
          '${mileage.averageMileageKmPerLiter!.toStringAsFixed(1)} km/L';
    }

    String costLabel = l10n.notEnoughData;
    if (cost.isAvailable && cost.costPerKmMajor != null) {
      costLabel = currency.formatMajor(cost.costPerKmMajor!);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.drivingSummary,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: l10n.distance,
                    value: '${number.format(summary.monthDistanceKm)} km',
                  ),
                ),
                Expanded(
                  child: _Metric(
                    label: l10n.fuelUsed,
                    value: '${summary.monthFuelLiters.toStringAsFixed(1)} L',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _Metric(label: l10n.mileage, value: mileageLabel),
                ),
                Expanded(
                  child: _Metric(label: l10n.costPerKm, value: costLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _UpcomingSection extends ConsumerWidget {
  const _UpcomingSection({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueAsync = ref.watch(dueServicesProvider);
    final remindersAsync = ref.watch(upcomingDashboardRemindersProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.upcoming,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/reminders'),
                  child: Text(l10n.seeAll),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            remindersAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (reminders) {
                if (reminders.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: reminders.take(3).map((Reminder reminder) {
                    final bool overdue =
                        reminder.status == ReminderStatus.overdue;
                    final bool isDocument =
                        reminder.relatedEntityType ==
                        ReminderEntityType.document;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        isDocument
                            ? Icons.description_outlined
                            : Icons.notifications_outlined,
                        color: overdue
                            ? AppColors.destructive
                            : AppColors.warning,
                      ),
                      title: Text(reminder.title),
                      subtitle: Text(
                        [
                          if (reminder.dueDate != null)
                            MaterialLocalizations.of(context)
                                .formatMediumDate(reminder.dueDate!),
                          if (reminder.dueOdometer != null)
                            '${reminder.dueOdometer} km',
                        ].join(' · '),
                      ),
                      trailing: Text(
                        overdue
                            ? l10n.overdue
                            : reminder.status == ReminderStatus.due
                                ? l10n.reminderDue
                                : l10n.dueSoon,
                      ),
                      onTap: () => context.push('/reminders/${reminder.id}'),
                    );
                  }).toList(),
                );
              },
            ),
            dueAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => Text(l10n.commonError),
              data: (items) {
                final reminders =
                    remindersAsync.asData?.value ?? const <Reminder>[];
                if (items.isEmpty && reminders.isEmpty) {
                  return Text(l10n.noMaintenanceDue);
                }
                if (items.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  children: items.take(3).map((DueServiceItem item) {
                    final bool overdue =
                        (item.remainingKm != null && item.remainingKm! <= 0) ||
                        (item.remainingDays != null &&
                            item.remainingDays! <= 0);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        item.sourceType == 'oil'
                            ? Icons.water_drop
                            : Icons.build_circle_outlined,
                        color: overdue
                            ? AppColors.destructive
                            : AppColors.warning,
                      ),
                      title: Text(item.title),
                      subtitle: Text(
                        [
                          if (item.remainingKm != null)
                            '${item.remainingKm} km',
                          if (item.remainingDays != null)
                            '${item.remainingDays} days',
                        ].join(' · '),
                      ),
                      trailing: Text(overdue ? l10n.overdue : l10n.dueSoon),
                      onTap: () => context.push(
                        item.sourceType == 'oil'
                            ? '/oil/${item.sourceId}'
                            : '/services/${item.sourceId}',
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: Icons.local_gas_station,
                label: l10n.addFuel,
                color: AppColors.fuel,
                onTap: () => context.push('/fuel/add'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.payments_outlined,
                label: l10n.addExpense,
                color: AppColors.maintenance,
                onTap: () => context.push('/expenses/add'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: Icons.build_outlined,
                label: l10n.addService,
                color: AppColors.success,
                onTap: () => context.push('/services/add'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.water_drop_outlined,
                label: l10n.addOilChange,
                color: AppColors.maintenance,
                onTap: () => context.push('/oil/add'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Icon(icon, color: color),
              const SizedBox(height: AppSpacing.xs),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentActivity extends StatelessWidget {
  const _RecentActivity({
    required this.items,
    required this.currency,
    required this.l10n,
  });

  final List<RecentActivityItem> items;
  final CurrencyFormatter currency;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.recentActivity,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => context.push('/expenses'),
              child: Text(l10n.seeAll),
            ),
          ],
        ),
        if (items.isEmpty)
          Text(l10n.recentActivityEmpty)
        else
          ...items.map((item) {
            return Card(
              child: ListTile(
                leading: Icon(switch (item.kind) {
                  RecentActivityKind.fuel => Icons.local_gas_station,
                  RecentActivityKind.expense => Icons.payments_outlined,
                  RecentActivityKind.odometer => Icons.speed,
                }, color: AppColors.primary),
                title: Text(item.title),
                subtitle: Text(
                  [
                    if (item.subtitle != null) item.subtitle!,
                    MaterialLocalizations.of(context)
                        .formatMediumDate(item.occurredAt),
                  ].join(' · '),
                ),
                trailing: item.amountPaisa == null
                    ? null
                    : Text(currency.formatPaisa(item.amountPaisa!)),
                onTap: item.routePath == null
                    ? null
                    : () => context.push(item.routePath!),
              ),
            );
          }),
      ],
    );
  }
}
