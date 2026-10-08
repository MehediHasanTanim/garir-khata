import 'package:garir_khata/features/settings/domain/preference_enums.dart';
import 'package:intl/intl.dart';

DateFormat preferredDateFormat(
  DateFormatPreference preference, {
  String? locale,
}) {
  return switch (preference) {
    DateFormatPreference.short => DateFormat.yMd(locale),
    DateFormatPreference.medium => DateFormat.yMMMd(locale),
    DateFormatPreference.long => DateFormat.yMMMMd(locale),
  };
}
