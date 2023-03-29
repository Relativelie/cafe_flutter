import 'package:flutter/material.dart';
import 'package:flutter_application_1/errors/networkError.dart';
import 'package:flutter_application_1/screens/recipes/widgets/sliverBar.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:flutter_application_1/utils/show_toast.dart';
import 'package:flutter_application_1/common_widgets/SliverCardsGrid.dart';
import 'package:flutter_application_1/common_widgets/inputField.dart';
import 'package:flutter_application_1/screens/recipes/widgets/recipeCard.dart';

import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../dto/recipes/recipes.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> with ChangeNotifier {
  final PagingController<String?, Recipe> _pagingController =
      PagingController(firstPageKey: null);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage();
    });
    super.initState();
  }

  Future<void> _fetchPage() async {
    final recipeProvider = context.read<RecipesService>();
    bool isFirstPage = recipeProvider.nextPage == null;
    try {
      if (isFirstPage) {
        _loadFirstPage(recipeProvider);
      } else {
        _loadNextPage(recipeProvider);
      }
    } on HttpException catch (e) {
      showToast(e.errors.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadFirstPage(RecipesService recipeProvider) async {
    await recipeProvider.loadRecipes();
    _appendPaginatedList(recipeProvider.recipes, recipeProvider.nextPage);
  }

  Future<void> _loadNextPage(RecipesService recipeProvider) async {
    await recipeProvider.loadNextRecipes();
    _appendPaginatedList(recipeProvider.recipes, recipeProvider.nextPage);
  }

  void _appendPaginatedList(List<Recipe> recipes, String? nextPage) {
    bool isLastPage = nextPage == null;
    if (isLastPage) {
      _pagingController.appendLastPage(recipes);
    } else {
      _pagingController.appendPage(recipes, nextPage);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> onChangeFilters(String val) async {
    final recipeProvider = context.read<RecipesService>();
    recipeProvider.changeFilter("q", val);
    recipeProvider.resetNextPageUrl();
    _pagingController.refresh();
    _fetchPage();
  }

  Widget createCard(Recipe item) {
    return RecipeCard(
      title: item.label,
      image: item.image,
      cuisineLabels: item.cuisineType,
      dietLabels: item.dietLabels,
      ingredients: item.ingredientLines.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          child: CustomScrollView(
            slivers: [
              SliverBar(),
              Consumer(
                builder: (context, provider, child) {
                  return SliverCardsGrid(
                      pagingController: _pagingController,
                      widgetCreator: createCard);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          title: Container(
        height: 35,
        alignment: Alignment.bottomRight,
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: InputField(
                    onSubmitted: (val) => onChangeFilters(val),
                    placeholder: "Search recipe",
                    leftIcon: Icons.search,
                    semanticIconLabel: "Search"
                    )),
            // TO DO THEME SETTINGS
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    color: Colors.yellow,
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
