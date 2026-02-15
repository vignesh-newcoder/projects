// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> datas;
  const NewScreen({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> datas =
    //     ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: ListView.builder(
        itemCount: datas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(datas[index]['Name']),
            subtitle: Text(datas[index]['Email']),
            trailing: Text(datas[index]['Password']),
          );
        },
      ),
    );
  }
}
