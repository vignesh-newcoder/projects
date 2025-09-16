import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/cart_provider.dart';
// ignore: unused_import
import 'package:shopping/globalVaiables.dart';

class Detailsofproducts extends StatefulWidget {
  final Map<String, Object> product;
  const Detailsofproducts({super.key, required this.product});

  @override
  State<Detailsofproducts> createState() => _DetailsofproductsState();
}

class _DetailsofproductsState extends State<Detailsofproducts> {
  int selectedsize = 0;

  void onTap() {
    if (selectedsize != 0) {
      Provider.of<Cartprovider>(context, listen: false).addproducts({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'sizes': selectedsize,
        'imagesUrl': widget.product['imagesUrl'],
        'company': widget.product['company'],
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.black,
          elevation: 100,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(55),
          ),
          content: Row(
            children: [
              Text(
                'Added to the cart',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  foreground: Paint(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.thumb_up_sharp,
                  color: const Color.fromARGB(255, 255, 230, 1),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.black,
          elevation: 100,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
          content: Row(
            children: [
              Text(
                'Please select an size',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  foreground: Paint(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.arrow_upward_sharp, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product['imagesUrl'] as String,
              height: 250,
            ),
          ),
          Spacer(flex: 2),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromRGBO(206, 229, 252, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product['sizes'] as List<int>)[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedsize = size;
                            });
                          },
                          child: Chip(
                            label: Text(
                              size.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: selectedsize == size
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(252, 240, 13, 1),
                      foregroundColor: Color.fromRGBO(0, 0, 0, 1),
                      fixedSize: Size(350, 50),
                    ),
                    label: Text(
                      'Add to cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
