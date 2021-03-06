import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/custom_routes.dart';
import 'package:flutter_complete_guide/screens/products_overview_screen.dart';
import 'package:flutter_complete_guide/screens/splash_screen.dart';

import '../providers/auth.dart';
import '../screens/add-edit_product_screen.dart';
import '../screens/admin_products_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/orders_screen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (ctx, auth, previousproducts) => Products(
                  auth.token,
                  auth.userId,
                  previousproducts == null ? [] : previousproducts.items)),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Order>(
              update: (ctx, auth, previousorders) => Order(
                    auth.token,
                    auth.userId,
                    previousorders == null ? [] : previousorders.orders,
                  )),
        ],
        // use create while using a new instance

        // value: Products(), donot use a value in main file
        child: Consumer<Auth>(
          builder: (context, authData, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
                fontFamily: 'Lato',
                primaryColor: Colors.purple,
                accentColor: Colors.deepOrange,
                appBarTheme: AppBarTheme(backgroundColor: Colors.purple),
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder()
                })),
            home: authData.isAuth
                ? ProductsScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (ctx, authSnapshot) =>
                        authSnapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductsScreen.routeName: (context) => ProductsScreen(),
              ProductDetail.routeName: (context) => ProductDetail(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductsScreen.namedRoute: (context) => EditProductsScreen(),
            },
          ),
        ));
  }
}
