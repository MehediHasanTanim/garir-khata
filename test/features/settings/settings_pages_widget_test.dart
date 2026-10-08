import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/app/localization/l10n/app_localizations.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:garir_khata/core/ui/app_states.dart';
import 'package:garir_khata/features/settings/presentation/settings_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('settings home lists sections', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsHomePage(),
        ),
      ),
    );

    expect(find.text('General'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Security'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('common empty and loading states render', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              Expanded(child: AppLoadingState(message: 'Loading')),
              Expanded(
                child: AppEmptyState(
                  title: 'Nothing here',
                  subtitle: 'Try again later',
                ),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Loading'), findsOneWidget);
    expect(find.text('Nothing here'), findsOneWidget);
  });
}
