import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicehub/providers/provider1.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    List history = Provider.of<DataProvider>(context).history;
    return Scaffold(
      appBar: AppBar(
        title: Text("ServiceHub"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: history.isEmpty
          ? Center(child: Text("No Bookings yet"))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(history[index]),
                );
              },
            ),
    );
  }
}
