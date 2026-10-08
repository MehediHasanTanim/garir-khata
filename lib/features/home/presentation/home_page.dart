import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:garir_khata/features/vehicles/application/vehicle_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final selectedVehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            selectedVehicle.when(
              data: (vehicle) => Text(
                vehicle?.nickname ?? l10n.selectedVehicleNone,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              loading: () => Text(l10n.commonLoading),
              error: (_, _) => Text(l10n.commonError),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.homePlaceholder,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
