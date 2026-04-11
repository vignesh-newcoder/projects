import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/providers/providerofitems.dart';
import 'package:provider/provider.dart';

class OrderedItems extends StatefulWidget {
  const OrderedItems({super.key});

  @override
  State<OrderedItems> createState() => _OrderedItemsState();
}

class _OrderedItemsState extends State<OrderedItems> {
  TextEditingController shopName = TextEditingController();
  TextEditingController phNumber = TextEditingController();

  final fb1 = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<GlobalProvider>();
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          if (orderProvider.orderList.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'No items is added yet',
                ),
              ),
            ),
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: orderProvider.orderList.length,
              itemBuilder: (context, index) {
                final item = orderProvider.orderList[index];
                final double itemTotal = (item["price"] as num).toDouble() * item["qty"];
                return Card(
                  child: ListTile(
                    title: Text(
                      item["name"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Qty: ${item["qty"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      itemTotal.toStringAsFixed(2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            "Total: ₹${orderProvider.totalAmount}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: orderProvider.orderList.isNotEmpty
                ? () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        bool? isPaid;
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text("Shop Details"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: shopName,
                                    decoration: const InputDecoration(labelText: 'Shop Name'),
                                  ),
                                  const SizedBox(height: 10),
                                  TextField(
                                    controller: phNumber,
                                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                                    decoration: const InputDecoration(labelText: "Phone Number"),
                                  ),
                                  SizedBox(height: 20),
                                  SegmentedButton(
                                    segments: [
                                      ButtonSegment(
                                        value: true,
                                        label: Text('Paid'),
                                      ),
                                      ButtonSegment(
                                        value: false,
                                        label: Text('Unpaid'),
                                      ),
                                    ],
                                    selected: {isPaid},
                                    onSelectionChanged: (newSelection) {
                                      setState(() {
                                        isPaid = newSelection.first;
                                      });
                                    },
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
                                    fb1.add({
                                      'shopName': shopName.text,
                                      'phno': int.parse(phNumber.text),
                                      'time': Timestamp.now(),
                                      'order': orderProvider.orderList,
                                      'totalAmount': orderProvider.totalAmount,
                                      'isPaid': isPaid ?? false,
                                    });

                                    context.read<GlobalProvider>().clearOrder();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        showCloseIcon: true,
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            )),
                                        margin: EdgeInsets.only(
                                          bottom: 90,
                                          left: 16,
                                          right: 16,
                                        ),
                                        duration: Duration(
                                          seconds: 20,
                                        ),
                                        content: Text(
                                          'Order is Placed  🚚',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Confirm"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 80,
                top: 15,
                right: 80,
                bottom: 15,
              ),
              child: Text(
                'Place Order',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
