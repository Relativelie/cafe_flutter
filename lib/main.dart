import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/Recipes.dart';
import 'package:flutter_application_1/services/methods.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/theme/light_theme.dart';
import 'package:flutter_application_1/theme/dark_theme.dart';

void main() async {
  // await DotEnv().load(fileName: '.env');
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecipesService>(
            create: (_) => RecipesService(Methods()))
      ],
      child:  MaterialApp(
        title: "mew mew mazaпкепкепкепкепкепfaka",
        home: Recipes(),
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
