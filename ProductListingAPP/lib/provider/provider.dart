import 'package:flutter/material.dart';

class Myprovider extends ChangeNotifier {
  //List of available items
  List<Map<String, dynamic>> productsList = [
    {
      'name': 'Fan',
      'price': 120,
      'ratings': 5.0,
      'image': 'assets/images/fan.png',
      'isFav': false,
    },
    {
      'name': 'Table',
      'price': 1200,
      'ratings': 5.0,
      'image': 'assets/images/Table.png',
      'isFav': false,
    },
    {
      'name': 'Phone',
      'price': 12000,
      'ratings': 4.5,
      'image': 'assets/images/phone.png',
      'isFav': false,
    },
    {
      'name': 'Book',
      'price': 130,
      'ratings': 4.9,
      'image': 'assets/images/book.png',
      'isFav': false,
    },
    {
      'name': 'TV',
      'price': 10000,
      'ratings': 3.7,
      'image': 'assets/images/TV.png',
      'isFav': false,
    },
    {
      'name': 'Bike',
      'price': 42000,
      'ratings': 4.6,
      'image': 'assets/images/Bike.png',
      'isFav': false,
    },
    {
      'name': 'Car',
      'price': 500000,
      'ratings': 3.7,
      'image': 'assets/images/car.png',
      'isFav': false,
    }
  ];

  List<Map<String, dynamic>> liked = [];
  List<Map<String, dynamic>> cart = [];
}
