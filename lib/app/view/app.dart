import 'package:electrometer/dashboard/dashboard.dart';
import 'package:electrometer/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ThemeData _theme;

  @override
  void initState() {
    super.initState();
    _theme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Segoe UI',
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        color: Color(0xFF21AD9E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF212121),
      colorScheme: ColorScheme.fromSwatch(
        primaryColorDark: const Color(0xFF21AD9E),
        backgroundColor: const Color(0xFF212121),
        accentColor: const Color(0xFF62EADB),
      ),
    );
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
