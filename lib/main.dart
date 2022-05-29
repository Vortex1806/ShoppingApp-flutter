import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/add-edit_product_screen.dart';
import 'package:flutter_complete_guide/screens/admin_products_screen.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products_provider.dart';
import 'providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Order()),
        ],
        // use create while using a new instance

        // value: Products(), donot use a value in main file
        child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            fontFamily: 'Lato',
            primaryColor: Colors.purple,
            accentColor: Colors.deepOrange,
            appBarTheme: AppBarTheme(backgroundColor: Colors.purple),
          ),
          home: ProductsScreen(),
          routes: {
            ProductDetail.routeName: (context) => ProductDetail(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductsScreen.namedRoute: (context) => EditProductsScreen(),
          },
        )
      );
  }
}
