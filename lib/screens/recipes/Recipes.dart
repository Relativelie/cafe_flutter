import 'package:flutter/material.dart';
import 'package:flutter_application_1/errors/networkError.dart';
import 'package:flutter_application_1/screens/recipes/widgets/filters.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:flutter_application_1/utils/show_toast.dart';
import 'package:flutter_application_1/common_widgets/SliverCardsGrid.dart';
import 'package:flutter_application_1/common_widgets/inputField.dart';
import 'package:flutter_application_1/screens/recipes/widgets/recipe_card.dart';

import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../dto/recipes/recipes.dart';

class ScreensRecipes extends StatefulWidget {
  const ScreensRecipes({super.key});

  @override
  State<ScreensRecipes> createState() => _ScreensRecipesState();
}

class _ScreensRecipesState extends State<ScreensRecipes> with ChangeNotifier {
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

  Future<void> _onChangeSearchVal(val) async {
    final recipeProvider = context.read<RecipesService>();
    recipeProvider.changeSearchVal(val);
    recipeProvider.resetFilters();
    reloadPage();
  }

  Future<void> reloadPage() async {
    final recipeProvider = context.read<RecipesService>();
    recipeProvider.resetNextPageUrl();
    _pagingController.refresh();
  }

  Widget _createCard(Recipe item) {
    print(item);
    return WdRecipeCard(
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
              WdFilters(reloadPage: reloadPage),
              Consumer(
                builder: (context, provider, child) {
                  return WdSliverCardsGrid(
                      pagingController: _pagingController,
                      widgetCreator: _createCard);
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
                child: WdInputField(
                    onSubmitted: (val) => _onChangeSearchVal(val),
                    placeholder: "Search recipe",
                    leftIcon: Icons.search,
                    semanticIconLabel: "Search")),
            // TO DO THEME SETTINGS
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
