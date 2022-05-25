import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//  remember to get the provider class products and not product
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) => ProductItem(
          id: products[index].id,
          title: products[index].title,
          imageUrl: products[index].imageUrl,
        ),
    );
  }
}
