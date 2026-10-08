import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/app/app.dart';
import 'package:garir_khata/core/database/app_database.dart';
import 'package:garir_khata/core/database/database_provider.dart';
import 'package:garir_khata/core/providers/core_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> pumpApp(
    WidgetTester tester, {
    Map<String, Object> prefs = const {},
  }) async {
    SharedPreferences.setMockInitialValues(prefs);
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final AppDatabase db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    final ProviderContainer container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const GarirKhataApp(),
      ),
    );
    return container;
  }

  testWidgets('fresh install starts on splash then language', (tester) async {
    await pumpApp(tester);
    await tester.pump();
    expect(find.textContaining('Garir Khata'), findsWidgets);

    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    expect(find.textContaining('language'), findsWidgets);
  });

  testWidgets('completed onboarding shows home navigation', (tester) async {
    await pumpApp(
      tester,
      prefs: {
        'settings.onboardingCompleted': true,
        'settings.languageConfirmed': true,
        'settings.locale': 'en',
      },
    );
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('language switching updates navigation labels', (tester) async {
    await pumpApp(
      tester,
      prefs: {
        'settings.onboardingCompleted': true,
        'settings.languageConfirmed': true,
        'settings.locale': 'en',
      },
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text('Bangla'),
      find.byType(ListView).first,
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bangla'));
    await tester.pumpAndSettle();

    expect(find.text('হোম'), findsWidgets);
    expect(find.text('ইতিহাস'), findsOneWidget);
  });

  testWidgets('onboarding can reach vehicle type selection', (tester) async {
    await pumpApp(tester);
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue').first);
    await tester.pumpAndSettle();

    expect(find.textContaining('vehicle records'), findsWidgets);

    await tester.tap(find.text('Add Vehicle'));
    await tester.pumpAndSettle();

    expect(find.textContaining('drive'), findsWidgets);
    expect(find.text('Motorcycle'), findsOneWidget);
  });
}
