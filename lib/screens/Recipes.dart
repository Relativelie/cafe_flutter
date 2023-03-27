import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:flutter_application_1/widgets/recipeCard.dart';
import 'package:provider/provider.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> with ChangeNotifier {
  late Future<void> _initialData;

  Future<void> _loadEntries() async {
    final recipeProvider = context.read<RecipesService>();
    await Future.wait([recipeProvider.getRecipes()]);
    // print(context.read<RecipesService>().recipes?[0].calories);
  }

  @override
  void initState() {
    super.initState();
    _initialData = _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final lala = context.read<RecipesService>().recipes;

            return Scaffold(
                body: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 24,
                      // width / height: fixed for *all* items
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => RecipeCard(
                          title: lala[index].label,
                          image: lala[index].image,
                          cuisineLabels: lala[index].cuisineType,
                          dietLabels: lala[index].dietLabels,
                          ingredients: lala[index].ingredientLines.length,
                        )),
                appBar: AppBar(
                  title: const Text('Sample Code'),
                ));
          } else
            return Scaffold(
              body: Text("loading..."),
            );
        });
  }
}
