import 'package:flutter/material.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';

Future<bool> confirmArchiveVehicle(BuildContext context) async {
  final l10n = context.l10n;
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.archiveVehicleTitle),
        content: Text(l10n.archiveVehicleMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.archive),
          ),
        ],
      );
    },
  );
  return confirmed ?? false;
}
