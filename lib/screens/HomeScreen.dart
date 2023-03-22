import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ChangeNotifier {
  late Future<void> _initialData;

  Future<void> _loadEntries() async {
    final recipeProvider = context.read<RecipesService>();
    await Future.wait([recipeProvider.getRecipes()]);
    // print(context.read<RecipesService>().recipes?[0].calories);
  }

  @override
  void initState() {
    super.initState();
    // Loading data here, since the build method can be called more than once
    _initialData = _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final lala = context.read<RecipesService>().recipes?[5];
            print('dietLabels ${lala?.label}');

            return Scaffold(
              body: Text(lala?.label ?? "sk"),
            );
          } else
            return Scaffold(
              body: Text("loading..."),
            );
        });
  }
}
