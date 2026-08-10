
import 'package:bloc_workout/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    List cart = Provider.of<Myprovider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: cart.isEmpty
          ? Center(child: Text('No items to display'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [
                      FadeInImage(
                        placeholder: AssetImage('assets/images/placeholdr.png'),
                        image: AssetImage(cart[index]['image']),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Name : ${cart[index]['name']}\n\n\n\n'),
                          Divider(),
                          Text('Price : ${cart[index]['price'].toString()}\n\n'),
                          Divider(),
                          Text('Ratings : '),
                          RatingStars(
                            value: cart[index]['ratings'],
                            maxValueVisibility: false,
                          )
                        ],
                      ),
                      Divider(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Buy now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[300],
                            ),
                            onPressed: () {
                              setState(() {
                                cart.remove(cart[index]);
                              });
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
