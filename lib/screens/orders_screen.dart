import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Order;
import '../widgets/orderItem.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders_page';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Order>(context, listen: false).setAndFetchOrders();
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
            ),
    );
  }
}
