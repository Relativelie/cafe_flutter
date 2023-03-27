import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/appTheme.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String image;
  final num ingredients;
  final List<String> cuisineLabels;
  final List<String> dietLabels;

  const RecipeCard(
      {required this.title,
      required this.image,
      required this.ingredients,
      required this.cuisineLabels,
      required this.dietLabels,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
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
              ...dietLabels.take(3).map((diet) => Text('#$diet')).toList()
            ]),
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(AppTheme.xsRadius),
                ),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(5),
                child: Text('${ingredients.toString()} INGREDIENTS'))
          ],
        ),
      ],
    );
  }
}
