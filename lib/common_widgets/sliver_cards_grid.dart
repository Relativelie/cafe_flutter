import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class WdSliverCardsGrid extends StatelessWidget {
  final PagingController<dynamic, dynamic> pagingController;
  final Function widgetCreator;
  const WdSliverCardsGrid(
      {required this.pagingController, required this.widgetCreator, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, child) {
        return PagedSliverGrid(
            pagingController: pagingController,
            showNoMoreItemsIndicatorAsGridChild: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 0.75,
            ),
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) {
                return widgetCreator(item);
              },
            ));
      },
    );
  }
}
