import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/add-edit_product_screen.dart';
import '../widgets/admin_page_list.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/admin-page';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(EditProductsScreen.namedRoute);
              }),
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  UserProductItem(
                    title: productData.items[i].title,
                    imgUrl: productData.items[i].imageUrl,
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}
