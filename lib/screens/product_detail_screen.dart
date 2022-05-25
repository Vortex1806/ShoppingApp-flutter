import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetail(this.title, this.price);

  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
