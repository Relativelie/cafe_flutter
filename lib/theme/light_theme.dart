import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/templates/colors.dart';
import 'package:flutter_application_1/theme/templates/text_styles.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: themeColors["blue"],
  highlightColor: themeColors["blue2"],
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: themeColors["blue2"])),
  canvasColor: themeColors["grey"],
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: themeColors["blue2"]),
  textTheme: const TextTheme(
    titleLarge: TextStyles.titleLarge,
    titleMedium: TextStyles.titleMedium,
    titleSmall: TextStyles.titleSmall,
    bodyLarge: TextStyles.bodyLarge,
    bodyMedium: TextStyles.bodyMedium,
    bodySmall: TextStyles.bodySmall,
    headlineSmall: TextStyles.bodyLargeCursive,
  ),
  colorScheme: const ColorScheme.light().copyWith(
    background: themeColors["white"],
    onBackground: themeColors["black"],
    secondary: themeColors["grey2"],
    onPrimary: themeColors["white"],
    primary: themeColors["pastel_pink"],
    error: themeColors["red"],
  ),
);
