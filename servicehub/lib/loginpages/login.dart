import 'package:flutter/material.dart';
import 'package:servicehub/loginpages/signup.dart';
import 'package:servicehub/pages/firstscreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
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
              Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset("assets/images/image1.jpeg", height: 90, width: 100),
                  SizedBox(height: 2),
                  Text(
                    "Service Hub",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Fix it fast, book it smart.",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Icon(Icons.miscellaneous_services),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 80),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildtext("Email Address"),
                      SizedBox(height: 5),
                      Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildcontainer("Enter your Email", Icons.email),
                            SizedBox(
                              height: 20,
                            ),
                            buildtext("Password"),
                            _buildcontainer("Enter your Password", Icons.password),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: buildtext("Forgot Password?"),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Firstscreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(7),
                                ),
                                fixedSize: Size(100, 50),
                              ),
                              child: buildtext("Log In"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => Signup()));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                fixedSize: Size(100, 50),
                              ),
                              child: buildtext("Sign In"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
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

Widget _buildcontainer(String hntxt, IconData ic) {
  return Container(
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(225, 95, 27, .3),
        blurRadius: 20,
        offset: Offset(0, 10),
      )
    ]),
    child: TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(7),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hntxt,
        prefixIcon: Icon(ic),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
  );
}
