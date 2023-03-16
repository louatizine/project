import 'package:flutter/material.dart';
import 'package:gestionConge/src/utils/theme/widget_themes/text_theme.dart';

import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  TAppTheme._();


  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme:
    ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );


  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: const AppBarTheme(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );
}