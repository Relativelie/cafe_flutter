import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Recipe {
  Recipe(
      {required this.label,
      required this.image,
      required this.url,
      required this.dietLabels,
      required this.healthLabels,
      required this.ingredientLines,
      required this.calories,
      required this.totalWeight,
      required this.totalTime,
      required this.cuisineType,
      required this.mealType,
      required this.dishType,
      required this.totalDaily});

  String label;
  String image;
  String url;
  List<String> dietLabels;
  List<String> healthLabels;
  List<String> ingredientLines;
  num calories;
  num totalWeight;
  num totalTime;
  List<String> cuisineType;
  List<String> mealType;
  List<String> dishType;
  Map<String, dynamic> totalDaily;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var recipe = Recipe(
      label: json["label"],
      image: json["image"],
      url: json["url"],
      dietLabels: List<String>.from(json['dietLabels']),
      healthLabels: List<String>.from(json['healthLabels']),
      ingredientLines: List<String>.from(json['ingredientLines']),
      calories: json["calories"],
      totalWeight: json["totalWeight"],
      totalTime: json["totalTime"],
      cuisineType: List<String>.from(json['cuisineType']),
      mealType: List<String>.from(json['mealType']),
      dishType: List<String>.from(json['dishType']),
      totalDaily: json["totalDaily"],
    );

    return recipe;
  }
}
