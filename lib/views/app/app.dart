import 'package:electrometer/l10n/l10n.dart';
import 'package:electrometer/views/app/elements/app_themes.dart';
import 'package:electrometer/views/dashboard/dashboard_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The base Flutter Application for the project.
class App extends StatefulWidget {
  /// Creates a new instance of the [App] class.
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The [ThemeData] for the application.
  late final ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _theme = AppThemes.darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    final MaterialApp baseApp = MaterialApp(
      theme: _theme,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DashboardPage(),
    );
    return kIsWeb
        ? Container(
            color: _theme.backgroundColor,
            child: Center(
              child: AspectRatio(aspectRatio: 9 / 14, child: baseApp),
            ),
          )
        : baseApp;
  }
}
