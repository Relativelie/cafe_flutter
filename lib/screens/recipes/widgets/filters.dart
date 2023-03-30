import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/common_widgets/bottomModal.dart';
import 'package:flutter_application_1/services/recipes.dart';
import 'package:provider/provider.dart';

class Filters extends StatefulWidget {
  final Function onChangeSearch;

  const Filters({required this.onChangeSearch, super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _isFiltersChanged = false;
  Map<String, dynamic> _filters = {};


  @override
  void initState() {
    super.initState();
    final recipeProvider = context.read<RecipesService>();
    _filters = recipeProvider.filters["diet"];
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        expandedHeight: 25.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Demo'),
        ),
        actions: [
          BottomModal(
              button: Icon(Icons.segment_outlined),
              modalContent: StatefulBuilder(builder: (BuildContext context,
                  StateSetter setState /*You can rename this!*/) {
                return Column(
                  children: [
                    ..._filters.entries.map((filter) {
                      return CheckboxListTile(
                        title: Text(filter.key),
                        value: filter.value,
                        onChanged: (newValue) {
                          setState(() {
                            _filters[filter.key] = newValue;
                            // _updateFiltersWidget();
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      );
                    }).toList(),
                    ElevatedButton(
                      child: Text(_isFiltersChanged ? "Accept" : "Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              }))
        ],
        backgroundColor: Colors.red);
  }
}
