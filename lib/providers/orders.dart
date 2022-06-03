import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.dateTime, this.products});
}

class Order with ChangeNotifier {
  final String authToken;
  final String userId;

  Order(this.authToken, this.userId, this._orders);
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> setAndFetchOrders() async {
    final url = Uri.parse(
        'https://myshop-64a2e-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title']))
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    final url = Uri.parse(
        'https://myshop-64a2e-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartproducts
              .map((cp) => {
                    'id': cp.id,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'title': cp.title
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartproducts));
    notifyListeners();
  }
}
