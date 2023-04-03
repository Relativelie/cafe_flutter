import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/templates/colors.dart';
import 'package:flutter_application_1/theme/templates/text_styles.dart';

ThemeData lightTheme = ThemeData(
  // brightness: Brightness.light,
  primaryColor: Colors.blue,
  highlightColor: themeColors["blue"],
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: themeColors["blue"])),
  canvasColor: themeColors["grey"],

  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: themeColors["green"]),
  textTheme: const TextTheme(
    titleLarge: TextStyles.titleLarge,
    titleMedium: TextStyles.titleMedium,
    titleSmall: TextStyles.titleSmall,
    bodyLarge: TextStyles.bodyLarge,
    bodyMedium: TextStyles.bodyMedium,
    bodySmall: TextStyles.bodySmall,
    headlineSmall: TextStyles.bodyLargeCursive,
  ),
  colorScheme: ColorScheme(
    background: Colors.white,
    onBackground: Colors.black,
    secondary: themeColors["grey2"]!,
    onPrimary: Colors.white,
    primary: themeColors["pastel_pink"]!,
    primaryVariant: Colors.blueAccent,
    secondaryVariant: Colors.redAccent,
    surface: Colors.white,
    error: Colors.red,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
