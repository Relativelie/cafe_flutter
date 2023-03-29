import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/appTheme.dart';
import 'package:flutter_application_1/utils/ellipsis_string.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String? image;
  final num ingredients;
  final List<String> cuisineLabels;
  final List<String> dietLabels;

  const RecipeCard(
      {required this.title,
      this.image,
      required this.ingredients,
      required this.cuisineLabels,
      required this.dietLabels,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                        image: NetworkImage(image ?? ""),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter),
                  ),
                ),
                Text(
                  ellipsisString(25, title),
                  // title,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: [
                Wrap(spacing: 5.0, alignment: WrapAlignment.center, children: [
                  ...cuisineLabels
                      .take(3)
                      .map((cuisine) => Text('#$cuisine'))
                      .toList(),
                  ...dietLabels
                      .take(3)
                      .map((diet) => Text('#$diet',
                          style: Theme.of(context).textTheme.bodySmall))
                      .toList()
                ]),
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(AppTheme.xsRadius),
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    child: Text('${ingredients.toString()} ingredients',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ],
            ),
          ],
        ));
  }
}
