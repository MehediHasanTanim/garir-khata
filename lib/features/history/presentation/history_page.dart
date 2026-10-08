import 'package:flutter/material.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.historyTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Text(
          l10n.historyPlaceholder,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
