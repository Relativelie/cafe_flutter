import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SliverBar extends StatelessWidget {
  const SliverBar({super.key});


  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      pinned: true,
      expandedHeight: 25.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Demo'),
      ),
      actions: [
        IconButton(
           icon: Icon(Icons.filter),
          onPressed: () {
            },
  tooltip: 'Open shopping cart',
  )
      ],
      backgroundColor: Colors.red
    );
  }
}
