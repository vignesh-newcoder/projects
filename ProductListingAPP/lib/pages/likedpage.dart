import 'package:bloc_workout/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    List liked = Provider.of<Myprovider>(context).liked;

    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Prodects'),
      ),
      body: liked.isEmpty
          ? Center(
              child: Text('No prodects to show'),
            )
          : ListView.builder(
              itemCount: liked.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: [
                      FadeInImage(
                        placeholder: AssetImage('assets/images/placeholdr.png'),
                        image: AssetImage(liked[index]['image']),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Name : ${liked[index]['name']}\n\n\n\n'),
                          Divider(),
                          Text('Price : ${liked[index]['price'].toString()}\n\n'),
                          Divider(),
                          Text('Ratings : '),
                          RatingStars(
                            value: liked[index]['ratings'],
                            maxValueVisibility: false,
                          )
                        ],
                      ),
                      Divider(
                        height: 20,
                      ),
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
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
