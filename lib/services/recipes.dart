import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/recipes/recipes.dart';
import 'package:flutter_application_1/models/recipes.dart';
import 'package:flutter_application_1/services/methods.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecipesService with ChangeNotifier {
  final Methods methods;
  RecipesService(this.methods);

  static final _edamamQueryParams = {
    "app_key": dotenv.env['API_RECIPES_KEY'],
    "app_id": dotenv.env['API_RECIPES_ID'],
    "type": "public",
  };
  static final _url = dotenv.env["BASE_RECIPES_URL"]!;

  List<Recipe> recipes = [];
  String? nextPage;
  Recipe? selectedRecipe;
  String searchingValue = "cherry";
  late Map<FiltersENUM, Map<String, bool>> filters = {
    FiltersENUM.diets: _generateFilter(diets),
    FiltersENUM.cuisine: _generateFilter(cuisine)
  };

  Map<String, bool> _generateFilter(List<String> filterList) {
    Map<String, bool> generatedFilter = {};
    filterList.asMap().forEach((index, e) {
      generatedFilter[e] = false;
    });
    return {...generatedFilter};
  }

  Map<String, List<String>> _parseFilterForQuery(String key) {
    List<String> checkedFilterValues = {...?filters[key]}
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return {key: checkedFilterValues};
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

  Future<void> loadRecipes() async {
    var parsedFilters = {
      SearchingQueryENUM.q.name: searchingValue,
      ..._parseFilterForQuery(FiltersENUM.diets.name),
      ..._parseFilterForQuery(FiltersENUM.cuisine.name)
    };
    await _getRecipes({..._edamamQueryParams, ...parsedFilters});
  }

  Future<void> loadNextRecipes() async {
    final queryParameters = Uri.parse(nextPage!).queryParametersAll;
    await _getRecipes(queryParameters);
  }

  void changeSearchVal(String value) {
    searchingValue = value;
  }

  void changeFilters(value) {
    filters = {...filters, ...value};
  }

  void resetNextPageUrl() {
    nextPage = null;
  }
}
