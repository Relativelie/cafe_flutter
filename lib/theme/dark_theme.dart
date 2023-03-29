import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/appTheme.dart';
import 'package:flutter_application_1/theme/templates/colors.dart';
import 'package:flutter_application_1/theme/templates/text_styles.dart';

final ThemeData darkTheme = ThemeData(
  // brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255, 24, 24, 24),
  highlightColor: themeColors["green2"],
  cardColor: Color.fromARGB(255, 195, 37, 37),

    progressIndicatorTheme: ProgressIndicatorThemeData(color: themeColors["green2"]),
  textTheme: TextTheme(
    titleLarge: TextStyles.titleLarge.copyWith(color: Colors.white),
    titleMedium: TextStyles.titleMedium.copyWith(color: Colors.white),
    titleSmall: TextStyles.titleSmall.copyWith(color: Colors.white),
    bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white),
    bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white),
    bodySmall: TextStyles.bodySmall.copyWith(color: Colors.white),
    headlineSmall: TextStyles.bodyLargeCursive.copyWith(color: Colors.white),
  ),

  colorScheme: ColorScheme(

        background: Colors.black,
            onBackground: Colors.white,


    onPrimary: Colors.black,
    primary: Colors.blue,
    primaryVariant: Colors.blueAccent,
    secondary: Colors.red,
    secondaryVariant: Colors.redAccent,
    surface: Colors.white,
    error: Colors.red,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
