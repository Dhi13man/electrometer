import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get darkTheme => ThemeData.dark().copyWith(
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
        backgroundColor: const Color(0xFF1B1B1B),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF62EADB),
          backgroundColor: const Color(0xFF212121),
          cardColor: const Color(0xFF21AD9E),
          primaryColorDark: const Color(0xFF21AD9E),
          primarySwatch: Colors.grey,
        ),
        scaffoldBackgroundColor: const Color(0xFF212121),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: (const Color(0xFF21AD9E)).withOpacity(0.75),
          elevation: 1,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: const Color(0xFF62EADB),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      );
}
