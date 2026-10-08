import 'package:flutter/material.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/reminders/domain/snooze_policy.dart';

Future<Duration?> showSnoozeSheet(BuildContext context) {
  return showModalBottomSheet<Duration>(
    context: context,
    builder: (context) {
      final l10n = context.l10n;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.snoozeReminder,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              ...SnoozePolicy.presets.map((duration) {
                return ListTile(
                  title: Text(_label(l10n, duration)),
                  onTap: () => Navigator.pop(context, duration),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}

String _label(dynamic l10n, Duration duration) {
  if (duration == SnoozePolicy.oneHour) {
    return l10n.snoozeOneHour as String;
  }
  if (duration == SnoozePolicy.fourHours) {
    return l10n.snoozeFourHours as String;
  }
  if (duration == SnoozePolicy.oneDay) {
    return l10n.snoozeOneDay as String;
  }
  if (duration == SnoozePolicy.threeDays) {
    return l10n.snoozeThreeDays as String;
  }
  return l10n.snoozeOneWeek as String;
}
