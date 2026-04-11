// lib/pages/homescreen.dart
//
// ✅ FIXED:
// 1. Now calls GeneratePdf.generateInvoicePdf() instead of the dead pdfvalue()
// 2. Shows loading dialog while PDF is being built in background
// 3. Error handling with SnackBar if PDF fails
// 4. Removed unused pdfgeneratingjsonfile import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pdfgenerator/pdf.dart'; // ← fixed import
import 'package:groceryapp/providers/providerofitems.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _onGeneratePdf(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Expanded(child: Text('Generating PDF, please wait…')),
          ],
        ),
      ),
    );

    try {
      final List<Map<String, dynamic>> items =
          List<Map<String, dynamic>>.from(data['order'] as List);

      await GeneratePdf.generateInvoicePdf(
        deliveryShopName: data['shopName'] as String,
        deliveryPhone: (data['phno']).toString(),
        items: items,
        totalAmount: data['totalAmount'] as num,
        orderDate: (data['time'] as Timestamp).toDate(),
      );

      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
    } catch (e) {
      print(data);
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            content: Text('PDF generation failed: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Provider.of<GlobalProvider>(context).appbar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').orderBy('time').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No Orders Placed yet'));
          }

          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshots.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final id = doc.id;

              final List details = data['order'];
              final Timestamp ts = data['time'];
              final DateTime dt = ts.toDate();
              final String dateTimeformat = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                elevation: 3,
                child: ExpansionTile(
                  title: Text(
                    "Shop name : ${data['shopName']}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number: ${data['phno']}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        dateTimeformat,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ ${data['totalAmount']}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: data['isPaid'] ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              data['isPaid'] ? "PAID" : "UNPAID",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    const Divider(),
                    ...details.map<Widget>(
                      (detail) => ListTile(
                        title: Text(detail['name']),
                        subtitle: Text("Qty: ${detail['qty']}  |  ₹ ${detail['price']}"),
                      ),
                    ),

                    // ── Mark as Paid ───────────────────────────────────────
                    if (!data['isPaid']) ...[
                      const Divider(),
                      TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Change to Paid'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(id)
                                        .update({'isPaid': true});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Paid', style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline_sharp, size: 20),
                        label: const Text('Paid', style: TextStyle(color: Colors.green)),
                      ),
                    ],

                    // ── Delete ─────────────────────────────────────────────
                    const Divider(),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Delete Order'),
                            content: const Text('Are you sure you want to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance.collection('orders').doc(id).delete();
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete Order', style: TextStyle(color: Colors.red)),
                    ),

                    // ── ✅ FIXED: Generate PDF ──────────────────────────────
                    const Divider(),
                    TextButton.icon(
                      onPressed: () => _onGeneratePdf(context, data),
                      icon: const Icon(Icons.picture_as_pdf_sharp, size: 20, color: Colors.black),
                      label: const Text(
                        'Generate PDF',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
