import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';

enum filterOptions {
  favorites,
  all,
}

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productscontainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (filterOptions selectedValue) {
                if (selectedValue == filterOptions.favorites) {
                  productscontainer.showFavoritesOnly();
                } else {
                  productscontainer.showAll();
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Favorites'),
                      value: filterOptions.favorites,
                    ),
                    PopupMenuItem(
                      child: Text('Show all'),
                      value: filterOptions.all,
                    )
                  ])
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
