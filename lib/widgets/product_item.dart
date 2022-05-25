import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        //to put a shape to the widget
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetail.routeName, arguments: id);
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            //widget to add at start of the bar = leading
            leading: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ),
        ));
  }
}
