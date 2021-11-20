// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// An Extension on [BuildContext] so we can easily get the [AppLocalizations]
/// instance of the context.
extension AppLocalizationsX on BuildContext {
  /// Returns the [AppLocalizations] instance of the context.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
