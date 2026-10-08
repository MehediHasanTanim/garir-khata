import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/router/app_router.dart';
import 'package:garir_khata/app/theme/app_theme.dart';
import 'package:garir_khata/features/reminders/presentation/reminder_lifecycle_host.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/settings/presentation/unlock_gate.dart';

class GarirKhataApp extends ConsumerWidget {
  const GarirKhataApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Garir Khata',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(highContrast: settings.highContrast),
      darkTheme: AppTheme.dark(highContrast: settings.highContrast),
      themeMode: settings.themeMode,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final systemScale = media.textScaler.scale(14) / 14;
        final textScaler = TextScaler.linear(
          (systemScale * (settings.largerText ? 1.2 : 1.0)).clamp(0.8, 1.8),
        );

        return MediaQuery(
          data: media.copyWith(textScaler: textScaler),
          child: ReminderLifecycleHost(
            child: AppSecurityHost(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
