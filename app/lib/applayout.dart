import 'package:app/SecongPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

class Applayout extends StatefulWidget {
  const Applayout({super.key});

  @override
  State<Applayout> createState() => _ApplayoutState();
}

class _ApplayoutState extends State<Applayout> {
  bool flag = false;
  String username = '';
  String mail = '';
  String password = '';
  bool val = true;
  List mydbdata = [];
  final myKey = GlobalKey<FormState>();

  TextEditingController tec1 = TextEditingController();
  TextEditingController tec2 = TextEditingController();
  TextEditingController tec3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Please fill the form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 350,
                height: 700,
                child: Form(
                  key: myKey,
                  child: Column(
                    children: [
                      create('Enter your name', 'Name', tec1),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password should not Empty';
                            }
                            return null;
                          },
                          controller: tec2,
                          obscureText: val,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    val = !val;
                                  });
                                },
                                icon: val ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black87,
                                width: 20,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                      create('Enter your mail', 'Mail', tec3),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: MaterialButton(
                          color: Colors.yellow[600],
                          onPressed: () {
                            if (myKey.currentState!.validate()) {
                              username = tec1.text;
                              password = tec2.text;
                              mail = tec3.text;

                              FirebaseFirestore.instance.collection('From_Data').add(
                                {
                                  'Name': username,
                                  'Password': password,
                                  'Email': mail,
                                },
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login Successful!'),
                                ),
                              );

                              myKey.currentState!.reset();
                              tec1.clear();
                              tec2.clear();
                              tec3.clear();

                              setState(
                                () {
                                  username = '';
                                  password = '';
                                  mail = '';
                                },
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Pleae the fill the form"),
                                ),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            side: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_a_photo_rounded),
                        onPressed: () async {
                          final image_picker = ImagePicker();

                          await Permission.photos.request();
                          var permission = await Permission.photos.status;
                          print(permission);

                          if (permission.isGranted) {
                            XFile? open = await image_picker.pickImage(source: ImageSource.gallery);
                            String pathGoted = open != null ? open.path : 'null';
                            print('We got it $pathGoted');
                          }
                        },
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/vicky.jpg'),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          List<Map<String, dynamic>> values = await getData();
                          if (values.isNotEmpty) {
                            setState(() {
                              flag = !flag;
                              mydbdata = values;
                            });
                            // ignore: use_build_context_synchronously
                            //Navigator.pushNamed(context, 'SecondPage', arguments: values);
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewScreen(
                                  datas: values,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text('Details'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }

  Widget create(String name1, String name2, TextEditingController newcontroller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return '$name2 should not empty';
          }
          return null;
        },
        controller: newcontroller,
        decoration: InputDecoration(
          labelText: name2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.black87,
              width: 20,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> getData() async {
  QuerySnapshot qs = await FirebaseFirestore.instance.collection('From_Data').get();
  return qs.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}
//TextFromField is suggested for  using to cerate an form ad logn page orelse signup page and more .
//maxlength
