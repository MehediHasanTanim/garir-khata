import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/app/localization/l10n/app_localizations.dart';
import 'package:garir_khata/core/errors/app_error.dart';
import 'package:garir_khata/core/result/result.dart';
import 'package:garir_khata/core/ui/async_result_feedback.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<BuildContext> pumpContext(WidgetTester tester) async {
    late BuildContext ctx;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            ctx = context;
            return const Scaffold(body: SizedBox.shrink());
          },
        ),
      ),
    );
    return ctx;
  }

  testWidgets('maps validation vs storage vs unexpected', (tester) async {
    final context = await pumpContext(tester);
    expect(
      userFacingErrorMessage(
        context,
        const ValidationError(message: 'Amount required', field: 'amount'),
      ),
      'Amount required',
    );
    expect(
      userFacingErrorMessage(context, const DatabaseError()),
      contains('storage'),
    );
    expect(
      userFacingErrorMessage(context, const FileError()),
      contains('storage'),
    );
    expect(
      userFacingErrorMessage(context, const UnexpectedError()),
      isNot(contains('SQL')),
    );
  });

  testWidgets('presentAsyncResult shows success snackbar', (tester) async {
    final context = await pumpContext(tester);
    presentAsyncResult(context, const Success<void>(null));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('presentAsyncResult shows failure snackbar', (tester) async {
    final context = await pumpContext(tester);
    presentAsyncResult(
      context,
      const Failure<void>(ValidationError(message: 'Bad odometer')),
    );
    await tester.pump();
    expect(find.text('Bad odometer'), findsOneWidget);
  });
}
