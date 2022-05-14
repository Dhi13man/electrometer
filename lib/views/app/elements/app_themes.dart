import 'package:flutter/material.dart';

class AppThemes {
  static const Color primaryThemeColor = Color.fromARGB(255, 207, 128, 71);
  static const Color primaryThemeColorLight =
      Color.fromARGB(255, 233, 221, 155);
  static const Color primaryDarkColor = Color.fromARGB(255, 27, 27, 27);
  static const Color primaryDarkerColor = Color.fromARGB(255, 24, 19, 13);

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
        backgroundColor: primaryDarkerColor,
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
        cardColor: primaryDarkColor,
        cardTheme: const CardTheme(
          color: primaryDarkColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          shadow: primaryThemeColorLight,
          outline: Color.fromARGB(255, 229, 234, 174),
          secondary: Color(0xFFE3DDDD),
          secondaryContainer: primaryThemeColorLight,
          primary: primaryThemeColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)
                      ? primaryDarkerColor
                      : primaryDarkColor,
            ),
            elevation: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)
                      ? 5
                      : 2.5,
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
        scaffoldBackgroundColor: primaryDarkerColor,
      );
}
