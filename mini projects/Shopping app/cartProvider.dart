import 'package:flutter/material.dart';

class Cartprovider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addproducts(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  void removeproducts(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}
