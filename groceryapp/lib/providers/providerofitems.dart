import 'package:flutter/material.dart';

class GlobalProvider extends ChangeNotifier {

  final List<Map<String, dynamic>> _orderList = [];

  List<Map<String, dynamic>> get orderList => _orderList;

  void addToOrder(String name, double price, int qty) {
    final index = _orderList.indexWhere((item) => item["name"] == name);

    
    if (index >= 0) {
      _orderList[index]["qty"] += qty;
      _orderList[index]["price"] = price;
    } else {
      _orderList.add({
        "name": name,
        "price": price,
        "qty": qty,
      });
    }

    notifyListeners();
  }

  void removeItem(String name) {
    _orderList.removeWhere((item) => item["name"] == name);
    notifyListeners();
  }

  void clearOrder() {
    _orderList.clear();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    for (var item in _orderList) {
      total += item["price"] * item["qty"];
    }
    return total;
  }

  PreferredSizeWidget appbar(){
    return AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: AlignmentGeometry.centerLeft,
            end: AlignmentGeometry.centerRight,
          ).createShader(bounds),
          child: Text(
            'JBM TRADERS',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}
