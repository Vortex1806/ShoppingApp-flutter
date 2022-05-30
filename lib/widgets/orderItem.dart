import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: widget.order.products.length * 20.0 + 100,
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, i) => Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: FittedBox(
                          child: Padding(
                              padding: EdgeInsets.all(2),
                              child:
                                  Text('\$${widget.order.products[i].price}')),
                        ),
                      ),
                      title: Text(widget.order.products[i].title),
                      subtitle: Text(
                          'Total: \$${(widget.order.products[i].price * widget.order.products[i].quantity).toStringAsFixed(2)}'),
                      trailing: Text('${widget.order.products[i].quantity} X'),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
