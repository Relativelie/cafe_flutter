import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/templates/colors.dart';
import 'package:flutter_application_1/theme/templates/text_styles.dart';

ThemeData lightTheme = ThemeData(
  // brightness: Brightness.light,
  primaryColor: Colors.blue,
  highlightColor: themeColors["green2"],

canvasColor: themeColors["grey"],

  progressIndicatorTheme: ProgressIndicatorThemeData(color: themeColors["green"]),
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
    secondary: themeColors["grey"]!,
    onPrimary: themeColors["green2"]!,


    primary: Colors.white,


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
