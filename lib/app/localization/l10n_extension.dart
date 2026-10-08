import 'package:flutter/widgets.dart';

import 'package:garir_khata/app/localization/l10n/app_localizations.dart';

export 'package:garir_khata/app/localization/l10n/app_localizations.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
