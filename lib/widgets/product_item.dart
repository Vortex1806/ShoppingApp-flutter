import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/Product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    //using consumer instead of provider of wrap widget in consumer
    // only wrap one button which needs the data
    return ClipRRect(
        //to put a shape to the widget
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ProductDetail.routeName, arguments: product.id);
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              )),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            //widget to add at start of the bar = leading
            //only changing one widget
            leading: Consumer<Product>(
              builder: (ctx, Product, _) => IconButton(
                //use ctx here
                color: Theme.of(context).accentColor,
                // color: Colors.deepOrange,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavorite(auth.token, auth.userId);
                },
              ),
              //give any child item here which does not change
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added Item to cart'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ));
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ));
  }
}
