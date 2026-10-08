import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/reminders/application/reminder_providers.dart';
import 'package:garir_khata/features/reminders/domain/entities/reminder.dart';
import 'package:garir_khata/features/reminders/domain/reminder_enums.dart';
import 'package:go_router/go_router.dart';

class RemindersPage extends ConsumerWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(reminderFilterProvider);
    final reminders = ref.watch(selectedVehicleRemindersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.remindersTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_outlined),
            tooltip: l10n.completedReminders,
            onPressed: () {
              ref
                  .read(reminderFilterProvider.notifier)
                  .setFilter(ReminderStatus.completed);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/reminders/add'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                _FilterChip(
                  label: l10n.reminderFilterAll,
                  selected: filter == null,
                  onSelected: () =>
                      ref.read(reminderFilterProvider.notifier).setFilter(null),
                ),
                _FilterChip(
                  label: l10n.reminderUpcoming,
                  selected: filter == ReminderStatus.upcoming,
                  onSelected: () => ref
                      .read(reminderFilterProvider.notifier)
                      .setFilter(ReminderStatus.upcoming),
                ),
                _FilterChip(
                  label: l10n.dueSoon,
                  selected: filter == ReminderStatus.dueSoon,
                  onSelected: () => ref
                      .read(reminderFilterProvider.notifier)
                      .setFilter(ReminderStatus.dueSoon),
                ),
                _FilterChip(
                  label: l10n.overdue,
                  selected: filter == ReminderStatus.overdue,
                  onSelected: () => ref
                      .read(reminderFilterProvider.notifier)
                      .setFilter(ReminderStatus.overdue),
                ),
                _FilterChip(
                  label: l10n.completedReminders,
                  selected: filter == ReminderStatus.completed,
                  onSelected: () => ref
                      .read(reminderFilterProvider.notifier)
                      .setFilter(ReminderStatus.completed),
                ),
              ],
            ),
          ),
          Expanded(
            child: reminders.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(child: Text(l10n.commonError)),
              data: (items) {
                if (items.isEmpty) {
                  return Center(child: Text(l10n.remindersEmpty));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final Reminder reminder = items[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications_outlined,
                          color: _statusColor(reminder.status),
                        ),
                        title: Text(reminder.title),
                        subtitle: Text(
                          [
                            _statusLabel(l10n, reminder.status),
                            if (reminder.dueDate != null)
                              MaterialLocalizations.of(context)
                                  .formatMediumDate(reminder.dueDate!),
                            if (reminder.dueOdometer != null)
                              '${reminder.dueOdometer} km',
                          ].join(' · '),
                        ),
                        onTap: () =>
                            context.push('/reminders/${reminder.id}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
