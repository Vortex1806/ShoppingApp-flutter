import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetail(this.title, this.price);

  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    //it will completely rebuild this pagr if listen not set to false
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(loadedProduct.title),
      ),
    );
  }
}
