import 'package:flutter/material.dart';
import 'package:flutter_application_1/dto/recipes/recipes.dart';
import 'package:flutter_application_1/errors/network_error.dart';
import 'package:flutter_application_1/models/recipes.dart';
import 'package:flutter_application_1/services/methods.dart';
import 'package:flutter_application_1/utils/show_toast.dart';
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
    for (var v in FiltersENUM.values) v: _generateFilter(allFiltersData[v]!)
  };

  Map<String, bool> _generateFilter(List<String> filterList) {
    Map<String, bool> generatedFilter = {};
    filterList.asMap().forEach((index, e) {
      generatedFilter[e] = false;
    });
    return {...generatedFilter};
  }

  List<String> _parseFilterForQuery(FiltersENUM key) {
    List<String> checkedFilterValues = {...?filters[key]}
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    return checkedFilterValues;
  }

  Future<void> _getRecipes(queryParameters) async {
    try {
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
  } on HttpException catch (e) {
      showToast(e.errors.toString());
    } catch (e) {
      print(e);
    }
    
  }

  Future<void> loadRecipes() async {
    var parsedFilters = {
      SearchingQueryENUM.q.name: searchingValue,
      for (var v in FiltersENUM.values) v.name: _parseFilterForQuery(v)
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
    value.forEach((k, v) => filters[k] = Map.from(v));
  }

  void resetNextPageUrl() {
    nextPage = null;
  }

  void resetFilters() {
    filters = {
      for (var v in FiltersENUM.values) v: _generateFilter(allFiltersData[v]!)
    };
  }
}
