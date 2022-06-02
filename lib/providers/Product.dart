import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  // final String userId;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    // @required this.userId,
    this.isFavorite = false,
  });

  void _setFavVal(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://myshop-64a2e-default-rtdb.asia-southeast1.firebasedatabase.app/userfavorites/$userId/$id.json?auth=$authToken');
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        _setFavVal(oldStatus);
      }
    } catch (error) {
      _setFavVal(oldStatus);
    }
  }
}
