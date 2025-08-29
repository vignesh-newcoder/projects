// ignore_for_file: file_names

// ignore: unused_import
import 'package:flutter/material.dart';

// ignore: camel_case_types
class CR_page extends StatefulWidget {
  const CR_page({super.key});
  @override
  State<CR_page> createState() => _CR_page();
}

// ignore: camel_case_types
class _CR_page extends State<CR_page> {
  final TextEditingController tec = TextEditingController();

  double result = 0;
  //Working body of my application

  void convertor() {
    result = double.parse(tec.text);
    result = result * 87.27;
    setState(() {});
  }

  void reset() {
    result = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(60),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 14, 234, 175),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 234, 175),
        elevation: 0,
        title: const Text(
          'Currency Convertor',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INR ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: tec,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Please Enter the amount in USD',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    prefixIconColor: Colors.black,
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: convertor,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Convert"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        tec.clear();
                        reset();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
