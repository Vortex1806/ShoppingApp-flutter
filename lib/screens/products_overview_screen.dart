import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_complete_guide/providers/products_provider.dart';
// import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum filterOptions {
  favorites,
  all,
}

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    // final productscontainer = Provider.of<Products>(context, listen: false);
    var _showonlyFavorites = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
              onSelected: (filterOptions selectedValue) {
                setState(() {
                  if (selectedValue == filterOptions.favorites) {
                    // productscontainer.showFavoritesOnly();
                    _showonlyFavorites = true;
                  } else {
                    // productscontainer.showAll();
                    _showonlyFavorites = false;
                  }
                });
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
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemcount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
      ),
      body: ProductsGrid(_showonlyFavorites),
    );
  }
}
