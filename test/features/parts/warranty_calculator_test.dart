import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/features/parts/domain/warranty.dart';

void main() {
  final now = DateTime(2026, 10, 8);

  test('unknown when warranty end is null', () {
    final state = WarrantyCalculator.evaluate(null, now: now);
    expect(state.status, WarrantyStatus.unknown);
  });

  test('active when more than 30 days remain', () {
    final state = WarrantyCalculator.evaluate(
      DateTime(2026, 12, 1),
      now: now,
    );
    expect(state.status, WarrantyStatus.active);
    expect(state.daysRemaining, greaterThan(30));
  });

  test('expiring soon within 30 days', () {
    final state = WarrantyCalculator.evaluate(
      DateTime(2026, 10, 20),
      now: now,
    );
    expect(state.status, WarrantyStatus.expiringSoon);
    expect(state.daysRemaining, 12);
  });

  test('expired when end date is in the past', () {
    final state = WarrantyCalculator.evaluate(
      DateTime(2026, 9, 1),
      now: now,
    );
    expect(state.status, WarrantyStatus.expired);
    expect(state.daysRemaining, lessThan(0));
  });
}
