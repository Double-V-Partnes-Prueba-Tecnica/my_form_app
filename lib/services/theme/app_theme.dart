import 'package:flutter/material.dart';

class AppTheme {
  // Font
  static const String fontName = 'Roboto'; // Text App
  static const String fontNameBold = 'Roboto-Bold'; // App Bar

  // Palette of Colors Light
  static const Color primaryColor = Color(0xFF001696); // Hex: #001696
  static const Color dividerColor = Color(0xFFBBBBBB); // Hex: #BBBBBB

  // Palette of Colors Dark
  static const Color primaryColorDark = Color(0xFF001696);
  static const Color dividerColorDark = Color(0xFFBBBBBB);

  // Theme Light
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Primary Color
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    // FloatingActionButton Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
      ),
    ),
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: dividerColor,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: primaryColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    ),
  );

  // Theme Dark
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Primary Color
    primaryColor: primaryColorDark,
    appBarTheme: const AppBarTheme(
      color: primaryColorDark,
      elevation: 0,
    ),
    // TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColorDark,
      ),
    ),
    // FloatingActionButton Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColorDark,
    ),
    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorDark,
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    ),
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: dividerColorDark,
    ),
  );
}
