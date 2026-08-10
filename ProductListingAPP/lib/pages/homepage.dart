import 'package:bloc_workout/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List pro = Provider.of<Myprovider>(context).productsList;
    List cart = Provider.of<Myprovider>(context).cart;
    List liked = Provider.of<Myprovider>(context).liked;
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce app'),
      ),
      body: ListView.builder(
        itemCount: pro.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                FadeInImage(
                  placeholder: AssetImage('assets/images/placeholdr.png'),
                  image: AssetImage(pro[index]['image']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Name : ${pro[index]['name']}\n\n\n\n'),
                    Divider(),
                    Text('Price : ${pro[index]['price'].toString()}\n\n'),
                    Divider(),
                    Text('Ratings : '),
                    RatingStars(
                      value: pro[index]['ratings'],
                      maxValueVisibility: false,
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        cart.add(pro[index]);
                      },
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          pro[index]['isFav'] = !pro[index]['isFav'];
                          if (pro[index]['isFav']) {
                            liked.add(pro[index]);
                          } else {
                            liked.remove(pro[index]);
                          }
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: pro[index]['isFav'] ? Colors.red[300] : Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
