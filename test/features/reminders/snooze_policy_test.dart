import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/features/reminders/domain/snooze_policy.dart';

void main() {
  final now = DateTime(2026, 10, 8, 12);

  test('snoozeUntil adds duration', () {
    expect(
      SnoozePolicy.snoozeUntil(now: now, duration: SnoozePolicy.oneDay),
      DateTime(2026, 10, 9, 12),
    );
  });

  test('rejects non-positive duration', () {
    expect(
      SnoozePolicy.snoozeUntil(now: now, duration: Duration.zero),
      isNull,
    );
  });

  test('suppresses notification while snoozed', () {
    expect(
      SnoozePolicy.shouldSuppressNotification(
        snoozedUntil: now.add(const Duration(hours: 2)),
        now: now,
      ),
      isTrue,
    );
    expect(
      SnoozePolicy.shouldSuppressNotification(
        snoozedUntil: now.subtract(const Duration(minutes: 1)),
        now: now,
      ),
      isFalse,
    );
  });
}
