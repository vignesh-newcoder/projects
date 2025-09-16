import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/cart_provider.dart';

class Addtocart extends StatelessWidget {
  const Addtocart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = (Provider.of<Cartprovider>(context).cart);
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body: Provider.of<Cartprovider>(context).cart.isEmpty
          ? Center(
              child: Text(
                'There is nothing here to show ,\n try add some products to cart',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      cartItem['imagesUrl'] as String,
                    ),
                    radius: 30,
                    backgroundColor: Color.fromRGBO(2, 243, 243, 0.985),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Remove Products',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Text(
                              'Are sure want to remove this from the cart',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Provider.of<Cartprovider>(
                                    context,
                                    listen: false,
                                  ).removeproducts(cartItem);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 255, 1, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<Cartprovider>();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      4,
                                      163,
                                      255,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                  title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text('Size : ${cartItem['sizes']}'),
                );
              },
            ),
    );
  }
}
