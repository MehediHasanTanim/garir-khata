import 'package:flutter_test/flutter_test.dart';
import 'package:garir_khata/core/analytics/privacy_safe_analytics.dart';

class _RecordingAnalytics implements Analytics {
  final List<(String, Map<String, Object?>)> events = [];

  @override
  void track(String event, [Map<String, Object?> properties = const {}]) {
    events.add((event, Map<String, Object?>.of(properties)));
  }
}

void main() {
  test('scrub drops blocked keys', () {
    final scrubbed = AnalyticsPrivacy.scrub({
      'screen': 'fuel',
      'registration_number': 'DHAKA-METRO-GA-12-3456',
      'documentNumber': 'FIT-99',
      'note': 'private workshop note',
      'attachment_path': '/data/files/a.jpg',
      'count': 3,
    });
    expect(scrubbed.keys, containsAll(['screen', 'count']));
    expect(scrubbed.containsKey('registration_number'), isFalse);
    expect(scrubbed.containsKey('documentNumber'), isFalse);
    expect(scrubbed.containsKey('note'), isFalse);
    expect(scrubbed.containsKey('attachment_path'), isFalse);
  });

  test('PrivacySafeAnalytics forwards only scrubbed props', () {
    final inner = _RecordingAnalytics();
    const PrivacySafeAnalytics(NoOpAnalytics()); // compile sanity
    final analytics = PrivacySafeAnalytics(inner);
    analytics.track('fuel_entry_created', {
      'vehicle_type': 'motorcycle',
      'pin': '1234',
      'file_name': 'receipt.png',
    });
    expect(inner.events, hasLength(1));
    expect(inner.events.single.$1, 'fuel_entry_created');
    expect(inner.events.single.$2, {'vehicle_type': 'motorcycle'});
  });

  test('NoOpAnalytics is safe default', () {
    const NoOpAnalytics().track('anything', {'registration_number': 'x'});
  });
}
