import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This is workaround so that autocomplete intellisence detect the app_localizations which is inside flutter gen
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalization on BuildContext {
  /// Returns the [AppLocalizations] instance.
  AppLocalizations? get locale => AppLocalizations.of(this);
}
