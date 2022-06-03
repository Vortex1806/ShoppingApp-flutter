import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Order;
import '../widgets/orderItem.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders_page';
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        //obtain future seperatrly as if build reruns everything reruns again
        future: Provider.of<Order>(context, listen: false).setAndFetchOrders(),
        // initialData: InitialData,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error Occoured'),
              );
            } else {
              return Consumer<Order>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
