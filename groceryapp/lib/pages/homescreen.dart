import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pdfgenerator/pdf.dart';
import 'package:groceryapp/providers/providerofitems.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Provider.of<GlobalProvider>(context).appbar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').orderBy('time').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return Center(
              child: Text('No Orders Placed yet'),
            );
          }

          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshots.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;
              var id = doc.id;
              List details = data['order'];
              Timestamp timedate = data['time'];
              DateTime dt = timedate.toDate();

              String dateTimeformat = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);

              return Card(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                elevation: 3,
                child: ExpansionTile(
                  title: Text(
                    "Shop name : ${data['shopName']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number: ${data['phno']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        dateTimeformat,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ ${data["totalAmount"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: data['isPaid'] ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              data['isPaid'] ? "PAID" : "UNPAID",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Divider(),
                    ...details.map<Widget>(
                      (detail) {
                        return ListTile(
                          title: Text(
                            detail['name'],
                          ),
                          subtitle: Text("Qty: ${detail['qty']}  |  ₹ ${detail['price']}"),
                        );
                      },
                    ),
                    if (!data['isPaid']) ...[
                      Divider(),
                      TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Change to  Paid'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('orders')
                                          .doc(id)
                                          .update({'isPaid': true});
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Paid',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.check_circle_outline_sharp, size: 20),
                        label: Text(
                          'Paid',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                    Divider(),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Delete Order'),
                              content: Text('Are you want to delete this'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('orders')
                                        .doc(id)
                                        .delete();

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                      label: Text(
                        'Delete Order',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Divider(),
                    TextButton.icon(
                      onPressed: () async {
                        try {
                          await GeneratePdf.generateInvoicePdf(
                            data['shopName'],
                            data['phno'].toString(),
                            data['order'],
                            data['totalAmount'],
                            (data['time'] as Timestamp).toDate(),
                          );
                        } catch (e) {
                          print("PDF ERROR: $e");
                        }
                      },
                      icon: Icon(
                        Icons.picture_as_pdf_sharp,
                        size: 20,
                      ),
                      label: Text(
                        'Generate pdf',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
