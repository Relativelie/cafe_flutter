import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/common_widgets/bottom_modal.dart';
import 'package:flutter_application_1/common_widgets/checkbox.dart';
import 'package:flutter_application_1/models/recipes.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:flutter_application_1/utils/text_capitalize.dart';

class WdFilters extends StatefulWidget {
  final Function reloadPage;

  const WdFilters({required this.reloadPage, super.key});

  @override
  State<WdFilters> createState() => _WdFiltersState();
}

class _WdFiltersState extends State<WdFilters> {
  bool _isFiltersChanged = false;
  final Map<FiltersENUM, Map<String, bool>> _filters = {};

  void _acceptFilterChanges() async {
    _closeModal();
    if (_isFiltersChanged) {
      context.read<RecipesService>().changeFilters(_filters);
      widget.reloadPage();
      setState(() {
        _isFiltersChanged = false;
      });
    }
  }

  void _closeModal() => Navigator.pop(context);

  bool _calcFiltersChanging(Map<FiltersENUM, Map<String, bool>> oldFilters,
      Map<FiltersENUM, Map<String, bool>> newFilters) {
    bool compareRes = true;
    oldFilters.forEach((k, v) {
      compareRes = compareRes && mapEquals(newFilters[k], oldFilters[k]);
    });
    return !compareRes;
  }

  void _onPressCheckboxItem({blockKey, key, newVal}) {
    _filters[blockKey]?[key] = newVal;
    final recipeProvider = context.read<RecipesService>();
    _isFiltersChanged = _calcFiltersChanging(_filters, recipeProvider.filters);
  }

  void _generateFiltersContent() {
    final recipeProvider = context.read<RecipesService>();
    recipeProvider.filters.forEach((k, v) => _filters[k] = Map.from(v));
  }

  Column _buildFilterBlock(
      FiltersENUM blockKey, Map<String, bool> filters, StateSetter setState) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(blockKey.name.capitalize(),
          style: Theme.of(context).textTheme.bodyLarge),
      ...filters.entries.map(
        (filter) {
          return SizedBox(
              height: 35,
              child: WdCheckbox(
                  title: filter.key.toString().capitalize(),
                  value: filter.value,
                  onChanged: (newVal) {
                    setState(() => _onPressCheckboxItem(
                        blockKey: blockKey, key: filter.key, newVal: newVal));
                  }));
        },
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Divider(
          thickness: 0.5,
          color: Theme.of(context).highlightColor,
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        expandedHeight: 25.0,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          title: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Look for recipes for every day with us',
                    style: Theme.of(context).textTheme.headlineSmall),
                Icon(Icons.favorite, color: Theme.of(context).highlightColor)
              ],
            ),
          ),
        ),
        actions: [
          WdBottomModal(
              onPressed: _generateFiltersContent,
              button: Icon(
                Icons.segment_outlined,
                size: 30,
                color: Theme.of(context).highlightColor,
              ),
              modalContent: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("Filters",
                            style: Theme.of(context).textTheme.titleSmall),
                        Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: _closeModal,
                              child: Text("Cancel",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      )),
                            )),
                      ],
                    ),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Expanded(
                          child: ListView(
                              physics: const ClampingScrollPhysics(),
                              children: [
                            ..._filters.entries.map((filterBlock) {
                              return _buildFilterBlock(
                                  filterBlock.key, filterBlock.value, setState);
                            }).toList(),
                            ElevatedButton(
                              onPressed: _acceptFilterChanges,
                              child:
                                  Text(_isFiltersChanged ? "Accept" : "Close"),
                            )
                          ]));
                    })
                  ],
                ),
              ))
        ],
        backgroundColor: Theme.of(context).colorScheme.secondary);
  }
}
