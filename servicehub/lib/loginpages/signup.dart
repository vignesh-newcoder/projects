
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.orangeAccent.shade200,
                Colors.orangeAccent.shade200,
                Colors.orangeAccent.shade200,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset("assets/images/image1.jpeg", height: 90, width: 100),
              SizedBox(height: 10),
              Text(
                "Service Hub",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Fix it fast, book it smart.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Icon(Icons.miscellaneous_services),
                  SizedBox(height: 60),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildtext("Email Address"),
                        SizedBox(height: 8),
                        buildtff("Enter your Email", Icons.email),
                        SizedBox(height: 16),
                        buildtext("Password"),
                        SizedBox(height: 8),
                        buildtff("Enter Your Password", Icons.password),
                        SizedBox(height: 16),
                        buildtext("Username"),
                        SizedBox(height: 8),
                        buildtff("Enter your Username", Icons.person),
                        SizedBox(height: 16),
                        buildtext("Phone Number"),
                        SizedBox(height: 8),
                        buildtff("Enter your 10-digit number", Icons.phone),
                        SizedBox(height: 25),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              fixedSize: Size(120, 40),
                            ),
                            child: buildtext("SignUp"),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildtext(String txt) {
  return Text(
    txt,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget buildtff(String txt, IconData ic) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Color.fromRGBO(225, 95, 27, .3), blurRadius: 20, offset: Offset(0, 10))
      ],
    ),
    child: TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: txt,
        focusColor: Colors.grey,
        prefixIcon: Icon(ic),
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white,
        filled: true,
      ),
    ),
  );
}
