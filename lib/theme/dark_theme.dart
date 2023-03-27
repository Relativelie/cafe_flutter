import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/appTheme.dart';
import 'package:flutter_application_1/theme/templates/colors.dart';
import 'package:flutter_application_1/theme/templates/text_styles.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
  highlightColor: themeColors["green2"],
  cardColor: Color.fromARGB(255, 195, 37, 37),
  textTheme: TextTheme(
    displayLarge: TextStyles.headline1.copyWith(color: Colors.white),
    displayMedium: TextStyles.headline2.copyWith(color: Colors.white),
    bodyLarge: TextStyles.bodyText1.copyWith(color: Colors.white),
    bodyMedium: TextStyles.bodyText2.copyWith(color: Colors.white),
  ),
  
);
