import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {

  final Widget child;
  final Widget title;
  const MyDropdown({
    super.key,
    required this.child,
    required this.title, required TabController tabController,
    });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined))
      ],
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('PVD Restaurant'),
      flexibleSpace: FlexibleSpaceBar(
      background: Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.all(10),
        expandedTitleScale: 1,


      ),
    );
  }
}