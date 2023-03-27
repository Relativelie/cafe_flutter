import 'package:flutter/material.dart';
import 'package:flutter_application_1/config.dart';
import 'package:flutter_application_1/dto/recipes/recipes.dart';
import 'package:flutter_application_1/services/methods.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



enum CuisineEnum {
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

enum DietEnum {
  balanced("balanced"),
  highFiber("high-fiber");

// high-protein,
// low-carb,
// low-fat,
// low-sodium,
  const DietEnum(this.text);
  final String text;
}

// void main() {
//   const day = Day.MONDAY;
//   print(day.text); /// Monday
// }

    // "app_id": DotEnv().env["API_RECIPES_ID"] ?? "",
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

  Future<void> getRecipes() async {
    const params = {"q": "cherry"};
    final queryParams = {..._edamamQueryParams, ...params};
    final recipesData = await methods.get(_url, params: queryParams);
    try {
      var arr = recipesData["hits"];
      if (arr.length != 0) {
        recipes =
            arr.map<Recipe>((item) => Recipe.fromJson(item["recipe"])).toList();
      } else {
        recipes = [];
      }
    } catch (error) {
      rethrow;
    }
  }
}
