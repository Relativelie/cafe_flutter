import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/recipes/screens_recipes.dart';
import 'package:flutter_application_1/services/methods.dart';
import 'package:flutter_application_1/services/model_theme.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/theme/light_theme.dart';
import 'package:flutter_application_1/theme/dark_theme.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<RecipesService>(
                  create: (_) => RecipesService(Methods()))
            ],
            child: MaterialApp(
              title: "Recipes",
              home: const ScreensRecipes(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
            ),
          );
        }));
  }
}
