import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
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
  static const routeName = '/product_screen';
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var _showonlyFavorites = false;
  var isInit = true;
  var isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchandSetProducts(); Wont work
    // Future.delayed(Duration.zero)
    //     .then((value) => Provider.of<Products>(context).fetchandSetProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //runs many times so add a check
    if (isInit) {
      isLoading = true;
      Provider.of<Products>(context).fetchandSetProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productscontainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
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
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showonlyFavorites),
    );
  }
}
