import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter_application_1/common_widgets/sliver_cards_grid.dart';
import 'package:flutter_application_1/common_widgets/input_field.dart';
import 'package:flutter_application_1/screens/recipes/widgets/filters.dart';
import 'package:flutter_application_1/screens/recipes/widgets/recipe_card.dart';
import 'package:flutter_application_1/services/model_theme.dart';
import 'package:flutter_application_1/services/recipes.dart';
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
    if (isFirstPage) {
      _loadFirstPage(recipeProvider);
    } else {
      _loadNextPage(recipeProvider);
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
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
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
          title: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: SizedBox(
                      height: 35,
                      child: WdInputField(
                          onSubmitted: (val) => _onChangeSearchVal(val),
                          placeholder: "Search recipe",
                          leftIcon: Icons.search,
                          semanticIconLabel: "Search"))),
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(
                        themeNotifier.isDark
                            ? Icons.nightlight_round
                            : Icons.wb_sunny,
                        color: Theme.of(context).colorScheme.background),
                    onPressed: () {
                      themeNotifier.isDark = !themeNotifier.isDark;
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
