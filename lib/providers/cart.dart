import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({this.id, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemcount {
    return _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //change quantity if aldready present
      _items.update(
          productId,
          (existingvalue) => CartItem(
              id: existingvalue.id,
              title: existingvalue.title,
              price: existingvalue.price,
              quantity: existingvalue.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          (() => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price)));
    }
    notifyListeners();
  }
}
