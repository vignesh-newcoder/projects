import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/providers/providerofitems.dart';

class Orderitems extends StatefulWidget {
  const Orderitems({super.key});

  @override
  State<Orderitems> createState() => _OrderitemsState();
}

class _OrderitemsState extends State<Orderitems> {
  final fb = FirebaseFirestore.instance.collection('products');
  List<Map<String, dynamic>> products = [
    //{"name": "Dried Red Chillies", "price": 195.0},
    // {"name": "Coriander Seeds", "price": 105.0},
    // {"name": "Cumin Seeds", "price": 68.0},
    // {"name": "Mustard Seeds", "price": 22.0},
    // {"name": "Fennel Seeds", "price": 40.0},
    // {"name": "Anjal", "price": 360.0},
    // {"name": "Tea Biscuits", "price": 49.0},
    // {"name": "Fried Gram", "price": 40.0},
    // {"name": "Toor Dal", "price": 108.0},
    // {"name": "Guava Jam", "price": 155.0},
    // {"name": "Eggs", "price": 8.28},
  ];
  bool isLoading = true;
  Map<String, int> quantities = {};

  Future<void> fetchProducts() async {
    try {
      final snapshot = await fb.get();

      products = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();

      quantities.clear();

      for (var p in products) {
        quantities[p["id"]] = 0;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void addItems() {
    TextEditingController itemNameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green[100],
          title: const Text(
            "Adding Items for Store",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: itemNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Item Name",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    )),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = itemNameController.text;
                final price = double.parse(priceController.text);
                if (name.isEmpty || price == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('The content should not be emtpy'),
                    ),
                  );
                  return;
                }

                try {
                  await fb.add({
                    'name': name,
                    'price': price,
                  });
                  Navigator.pop(context);
                  fetchProducts();
                } catch (e) {
                  print('Eorror occured $e');
                }
              },
              child: const Text("Insert"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteItem(int index) async {
    final prodectId = products[index]['id'];

    await fb.doc(prodectId).delete();

    fetchProducts();
  }

  Future<void> editItem(int index) async {
    final item = products[index];

    TextEditingController itemNameController = TextEditingController(text: item["name"]);
    TextEditingController priceController = TextEditingController(text: item["price"].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green[100],
          title: const Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: itemNameController,
                decoration: const InputDecoration(labelText: "Item Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: "Price"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await fb.doc(products[index]['id']).update({
                  'name': itemNameController.text.trim(),
                  'price': double.tryParse(priceController.text),
                });
                Navigator.pop(context);
                fetchProducts();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator.adaptive());
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.red,
              Colors.blue,
            ],
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
      ),
      body: Column(
        children: [
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              addItems();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[100],
            ),
            child: Text(
              'Add Extra Items',
              style: TextStyle(color: Colors.black),
            ),
          ),
          if (products.isNotEmpty) SizedBox(height: 20),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: products.isEmpty
                ? Center(child: Text("There is no items to Order"))
                : GridView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final name = product["name"];
                      final price = product["price"];
                      final qty = quantities[name] ?? 0;

                      return Card(
                        color: Colors.green[100],
                        margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    child: Icon(Icons.edit, color: Colors.green),
                                    onPressed: () {
                                      editItem(index);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      deleteItem(index);
                                    },
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: Text(
                                        name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "₹${price * qty}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          iconSize: 25,
                                        ),
                                        icon: const Icon(Icons.remove, color: Colors.red),
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          if (qty == 0) {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              closeIconColor: Colors.black,
                                              backgroundColor: Colors.green,
                                              behavior: SnackBarBehavior.floating,
                                              shape: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  )),
                                              margin: EdgeInsets.only(
                                                bottom: 50,
                                                left: 16,
                                                right: 16,
                                              ),
                                              content: Text(
                                                'Select atleast one item',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ));
                                          } else {
                                            setState(() {
                                              quantities[name] = qty - 1;
                                            });
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            qty.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          iconSize: 25,
                                        ),
                                        icon: const Icon(Icons.add, color: Colors.green),
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () {
                                          setState(() {
                                            quantities[name] = qty + 1;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: qty > 0
                                        ? () {
                                            context
                                                .read<GlobalProvider>()
                                                .addToOrder(name, price, qty);
                                            setState(() {
                                              quantities[name] = 0;
                                            });

                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              showCloseIcon: true,
                                              backgroundColor: Colors.green,
                                              behavior: SnackBarBehavior.floating,
                                              shape: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  )),
                                              margin: EdgeInsets.only(
                                                bottom: 50,
                                                left: 16,
                                                right: 16,
                                              ),
                                              content: Text(
                                                '$name is successsfully added 🎉',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ));
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                    child: const Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
