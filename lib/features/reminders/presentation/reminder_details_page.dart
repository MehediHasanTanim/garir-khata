import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:garir_khata/features/reminders/presentation/snooze_sheet.dart';
import 'package:go_router/go_router.dart';

class ReminderDetailsPage extends ConsumerWidget {
  const ReminderDetailsPage({required this.reminderId, super.key});

  final String reminderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(reminderByIdProvider(reminderId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reminderDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/reminders/$reminderId/edit'),
          ),
        ],
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.commonError)),
        data: (reminder) {
          if (reminder == null) {
            return Center(child: Text(l10n.commonError));
          }
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              Text(
                reminder.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Chip(
                label: Text(_statusLabel(l10n, reminder.status)),
                backgroundColor:
                    _statusColor(reminder.status).withValues(alpha: 0.12),
              ),
              if (reminder.description != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(reminder.description!),
              ],
              const SizedBox(height: AppSpacing.md),
              _row(
                context,
                l10n.reminderType,
                switch (reminder.reminderType) {
                  ReminderKind.date => l10n.reminderTypeDate,
                  ReminderKind.odometer => l10n.reminderTypeOdometer,
                  ReminderKind.combined => l10n.reminderTypeCombined,
                },
              ),
              if (reminder.dueDate != null)
                _row(
                  context,
                  l10n.fieldDueDate,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(reminder.dueDate!),
                ),
              if (reminder.dueOdometer != null)
                _row(
                  context,
                  l10n.fieldDueOdometer,
                  '${reminder.dueOdometer} km',
                ),
              _row(context, l10n.fieldAdvanceDays, '${reminder.advanceDays}'),
              _row(context, l10n.fieldAdvanceKm, '${reminder.advanceKm}'),
              if (reminder.snoozedUntil != null)
                _row(
                  context,
                  l10n.snoozedUntil,
                  MaterialLocalizations.of(context)
                      .formatMediumDate(reminder.snoozedUntil!),
                ),
              if (!reminder.isTerminal) ...[
                const SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: () async {
                    final Duration? duration =
                        await showSnoozeSheet(context);
                    if (duration == null || !context.mounted) {
                      return;
                    }
                    await ref
                        .read(reminderActionsProvider)
                        .snooze(reminderId, duration);
                    ref.invalidate(reminderByIdProvider(reminderId));
                    ref.invalidate(selectedVehicleRemindersProvider);
                    ref.invalidate(upcomingDashboardRemindersProvider);
                  },
                  child: Text(l10n.snoozeReminder),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(reminderActionsProvider).complete(reminderId);
                    ref.invalidate(reminderByIdProvider(reminderId));
                    ref.invalidate(selectedVehicleRemindersProvider);
                    ref.invalidate(upcomingDashboardRemindersProvider);
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  child: Text(l10n.completeReminder),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: () async {
                    await ref.read(reminderActionsProvider).skip(reminderId);
                    ref.invalidate(selectedVehicleRemindersProvider);
                    ref.invalidate(upcomingDashboardRemindersProvider);
                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  child: Text(l10n.skipReminder),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.destructive,
                ),
                onPressed: () async {
                  final Result<void> result = await ref
                      .read(reminderRepositoryProvider)
                      .delete(reminderId);
                  if (result.isSuccess) {
                    await ref
                        .read(notificationSchedulerProvider)
                        .cancelReminder(reminderId);
                    ref.invalidate(selectedVehicleRemindersProvider);
                    ref.invalidate(upcomingDashboardRemindersProvider);
                    if (context.mounted) {
                      context.go('/reminders');
                    }
                  }
                },
                child: Text(l10n.commonDelete),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _statusColor(ReminderStatus status) => switch (status) {
        ReminderStatus.overdue => AppColors.destructive,
        ReminderStatus.due || ReminderStatus.dueSoon => AppColors.warning,
        ReminderStatus.completed => AppColors.primary,
        _ => AppColors.textSecondary,
      };

  String _statusLabel(dynamic l10n, ReminderStatus status) => switch (status) {
        ReminderStatus.upcoming => l10n.reminderUpcoming as String,
        ReminderStatus.dueSoon => l10n.dueSoon as String,
        ReminderStatus.due => l10n.reminderDue as String,
        ReminderStatus.overdue => l10n.overdue as String,
        ReminderStatus.completed => l10n.completedReminders as String,
        ReminderStatus.skipped => l10n.reminderSkipped as String,
      };

  Widget _row(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
