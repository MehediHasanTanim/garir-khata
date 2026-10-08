import 'package:flutter/material.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportsTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Text(
          l10n.reportsPlaceholder,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
