import 'package:electrometer/l10n/l10n.dart';
import 'package:electrometer/views/app/elements/app_themes.dart';
import 'package:electrometer/views/dashboard/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  /// Creates a new instance of the [App] class.
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The [ThemeData] for the application.
  late final ThemeData _theme;

  /// The [Future] that resolves when all the asynchronous initializations of
  /// the app are ready.
  late final Future<void> _initialization;

  @override
  void initState() {
    _initialization = Future.wait(
      <Future<void>>[
        Firebase.initializeApp(),
      ],
    );
    Firebase.initializeApp();
    super.initState();
    _theme = AppThemes.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    final Widget baseApp = FutureBuilder<void>(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<void> state) {
        if (state.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.hasError) {
          return const Center(child: Text('Error'));
        } else {
          return MaterialApp(
            theme: AppThemes.darkTheme,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const DashboardScreen(),
          );
        }
      },
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
