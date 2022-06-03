import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/screens/admin_products_screen.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('SignIn'),
            backgroundColor: Theme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            //no backbutton
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(CartScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(UserProductsScreen.routeName);
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
