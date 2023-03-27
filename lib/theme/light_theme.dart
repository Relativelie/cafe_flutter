import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/templates/colors.dart';
import 'package:flutter_application_1/theme/templates/text_styles.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color.fromARGB(255, 79, 243, 33),
  highlightColor: themeColors["green2"],
    // cardColor: Color.fromARGB(255, 195, 37, 37),
  textTheme: const TextTheme(
    displayLarge: TextStyles.headline1,
    displayMedium: TextStyles.headline2,
    bodyLarge: TextStyles.bodyText1,
    bodyMedium: TextStyles.bodyText2,
  ),
);
