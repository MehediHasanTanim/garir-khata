import 'package:flutter/material.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';

enum OdometerLowerAction { correct, reset, cancel }

Future<OdometerLowerAction> showOdometerLowerDialog(
  BuildContext context, {
  required int previous,
  required int entered,
}) async {
  final l10n = context.l10n;
  final OdometerLowerAction? action = await showDialog<OdometerLowerAction>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.odometerLowerTitle),
        content: Text(
          l10n.odometerLowerMessage(previous.toString(), entered.toString()),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(OdometerLowerAction.cancel),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(OdometerLowerAction.correct),
            child: Text(l10n.odometerCorrectValue),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pop(OdometerLowerAction.reset),
            child: Text(l10n.odometerWasReset),
          ),
        ],
      );
    },
  );
  return action ?? OdometerLowerAction.cancel;
}
