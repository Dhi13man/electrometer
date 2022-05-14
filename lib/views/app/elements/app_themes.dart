import 'package:flutter/material.dart';

class AppThemes {
  static const Color primaryThemeColor = Color.fromARGB(255, 203, 127, 4);
  static const Color primaryThemeColorLight = Color.fromARGB(255, 234, 214, 98);
  static const Color primaryDarkColor = Color(0xFF1B1B1B);
  static const Color primaryDarkerColor = Color.fromARGB(255, 18, 11, 4);

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          color: primaryThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        backgroundColor: primaryDarkColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryThemeColor.withOpacity(0.75),
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
          unselectedItemColor: primaryThemeColorLight,
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        cardColor: primaryDarkerColor,
        cardTheme: const CardTheme(
          color: primaryDarkerColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          shadow: primaryThemeColorLight,
          outline: Color(0xFFAEEAE3),
          secondary: Color(0xFFE3DDDD),
          secondaryContainer: primaryThemeColor,
          primary: primaryThemeColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)
                      ? primaryDarkColor
                      : const Color(0xFF303030),
            ),
            elevation: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)
                      ? 10
                      : 5,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                side: BorderSide(color: primaryThemeColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            shadowColor:
                MaterialStateProperty.all<Color>(primaryThemeColorLight),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: primaryThemeColor,
                fontFamily: 'Segoe UI',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        scaffoldBackgroundColor: primaryDarkColor,
      );

  static ThemeData get lightTheme => ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          color: primaryThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        backgroundColor: primaryDarkColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryThemeColor.withOpacity(0.75),
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
          unselectedItemColor: primaryThemeColorLight,
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Segoe UI',
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        cardColor: primaryDarkerColor,
        cardTheme: const CardTheme(
          color: primaryDarkerColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          shadow: primaryThemeColorLight,
          outline: Color.fromARGB(255, 174, 234, 227),
          secondary: Color.fromARGB(255, 227, 221, 221),
          secondaryContainer: primaryThemeColor,
          primary: primaryThemeColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)
                      ? primaryDarkColor
                      : const Color(0xFF303030),
            ),
            elevation: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)
                      ? 10
                      : 5,
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                side: BorderSide(color: primaryThemeColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            shadowColor:
                MaterialStateProperty.all<Color>(primaryThemeColorLight),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: primaryThemeColor,
                fontFamily: 'Segoe UI',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        scaffoldBackgroundColor: primaryDarkColor,
      );
}
