import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/recipes/recipes.dart';
import 'package:flutter_application_1/errors/networkError.dart';
import 'package:flutter_application_1/services/methods.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum CuisineENUM {
  american,
  asian,
  british,
  caribbean,
// centralEurope: "central europe",
  chinese,
// "eastern europe",
  french,
  greek,
  indian,
  italian,
  japanese,
  korean,
  kosher,
  mediterranean,
  mexican,
// middle eastern,
  nordic,
// a: "south american",
// south east asian,
  world,
}

enum DietENUM {
  balanced("balanced"),
  highFiber("high-fiber");

// high-protein,
// low-carb,
// low-fat,
// low-sodium,
  const DietENUM(this.text);
  final String text;
}

// void main() {
//   const day = Day.MONDAY;
//   print(day.text); /// Monday
// }

List<String> diets = ["balanced", "high-fiber", "high-protein"];

enum FiltersENUM { q, diet }

class RecipesService with ChangeNotifier {
  final Methods methods;
  RecipesService(this.methods);

  final _edamamQueryParams = {
    "app_key": dotenv.env['API_RECIPES_KEY'],
    "app_id": dotenv.env['API_RECIPES_ID'],
    "type": "public",
  };
  final _url = dotenv.env["BASE_RECIPES_URL"]!;

  List<Recipe> recipes = [];
  Recipe? selectedRecipe;
  String? nextPage;
  late Map<String, dynamic> filters = {
    "q": "cherry",
    "diet": _generateFilters()
  };

  Map<String, dynamic> _generateFilters() {
    Map<String, dynamic> myMap = {};

    diets.asMap().forEach((index, e) {
      print("value ${e}");
      myMap[e] = true;
    });
    print('myMap ${myMap}');
    return {...myMap};
    filters["diet"] = {...myMap};
    print('filters ${filters}');
  }

  Future<void> loadRecipes() async {
    final queryParams = {..._edamamQueryParams, "q": filters["q"]};
    // print("queryParams ${filters}");
    await _getRecipes(queryParams);
  }

  Future<void> loadNextRecipes() async {
    final queryParameters = Uri.parse(nextPage!).queryParametersAll;
    await _getRecipes(queryParameters);
  }

  Future<void> _getRecipes(queryParameters) async {
    final res = await methods.get(_url, params: queryParameters);
    var recipesData = res["hits"];
    if (recipesData.length != 0) {
      recipes = recipesData
          .map<Recipe>((item) => Recipe.fromJson(item["recipe"]))
          .toList();
      nextPage = res["_links"]["next"]?["href"];
    } else {
      recipes = [];
    }
  }

  void changeFilter(String key, value) {
    filters[key] = value;
  }

  void resetNextPageUrl() {
    nextPage = null;
  }
}
