import 'package:flutter/Material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  bool done = false;
  Color color = Color.fromRGBO(161, 161, 161, 1);
  String inputValue = '';
  String calculatedVAlue = '';
  bool isData = false;
  String showingValue = '';

  double? total;

  String operator = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 150, right: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    showingValue,
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    calc('AC', color),
                    calc('%', color),
                    calc('⌫', color),
                    calc('÷', Color.fromRGBO(243, 152, 5, 1)),
                  ],
                ),
                Row(
                  children: [
                    calc('7', color),
                    calc('8', color),
                    calc('9', color),
                    calc('-', Color.fromRGBO(243, 152, 5, 1)),
                  ],
                ),
                Row(
                  children: [
                    calc('4', color),
                    calc('5', color),
                    calc('6', color),
                    calc('x', Color.fromRGBO(243, 152, 5, 1)),
                  ],
                ),
                Row(
                  children: [
                    calc('1', color),
                    calc('2', color),
                    calc('3', color),
                    calc('+', Color.fromRGBO(243, 152, 5, 1)),
                  ],
                ),
                Row(
                  children: [
                    calc('00', color),
                    calc('0', color),
                    calc('.', color),
                    calc('=', Color.fromRGBO(243, 152, 5, 1)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget calc(String name, Color bgcolor) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (name == 'AC') {
          setState(() {
            inputValue = '';
            operator = '';
            calculatedVAlue = '';
            showingValue = '';
            total = null;
            done = false;
          });
        } else if (name == '⌫') {
          setState(() {
            if (inputValue.isNotEmpty) {
              inputValue = inputValue.substring(0, inputValue.length - 1);
              showingValue = showingValue.substring(0, showingValue.length - 1);
            }
          });
        } else if (['+', '-', '%', 'x', '÷'].contains(name)) {
          setState(() {
            if (total == null && inputValue.isNotEmpty) {
              total = double.parse(inputValue);
            } else if (total != null && inputValue.isNotEmpty) {
              total = double.parse(
                sum(total!, double.parse(inputValue), operator),
              );
            }
            operator = name;
            inputValue = '';
            showingValue += name;
          });
        } else if (name == '=') {
          setState(() {
            if (total != null && inputValue.isNotEmpty) {
              String result = sum(total!, double.parse(inputValue), operator);
              showingValue = result;
              inputValue = result;
              total = double.parse(result);
              done = true;
            }
            inputValue = '';
            operator = '';
          });
        } else {
          setState(() {
            if (done && operator == '') {
              inputValue = '';
              showingValue = '';
              done = false;
            }
            inputValue += name;
            showingValue += name;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: bgcolor,
        ),
        margin: EdgeInsets.all(10.0),
        height: height / 12,
        width: width / 5,
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  String sum(double a, double b, String operator) {
    String ans = '';
    switch (operator) {
      case '+':
        ans = (a + b).toString();
        break;
      case '-':
        ans = (a - b).toString();
        break;
      case 'x':
        ans = (a * b).toString();
        break;
      case '÷':
        ans = (a / b).toString();
        break;
      case '%':
        ans = (a % b).toString();
        break;
    }
    double duplicate = double.parse(ans);
    if (duplicate % 1 == 0) {
      ans = duplicate.toInt().toString();
    }
    return ans;
  }
}
