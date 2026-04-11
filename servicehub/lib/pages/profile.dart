import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEdit = false;
  final TextEditingController nameController = TextEditingController(text: "Komala");
  final TextEditingController addressController = TextEditingController(text: "Krishnagiri");
  final TextEditingController phoneController = TextEditingController(text: "9876543210");
  final TextEditingController emailController = TextEditingController(text: "vkoms426@gmail.com");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ServiceHub"),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(isEdit ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEdit = !isEdit;
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
              radius: 36,
              backgroundColor: Colors.white,
              child: Image.asset("assets/images/img_1.png")),
          SizedBox(
            height: 20,
          ),
          buildTextFiled("Name", nameController, isEdit),
          buildTextFiled("Address", addressController, isEdit),
          buildTextFiled("Email", emailController, isEdit),
          buildTextFiled("Phone", phoneController, isEdit),
        ],
      ),
    );
  }
}

Widget buildTextFiled(String lb, TextEditingController controller, bool isEditing) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      controller: controller,
      enabled: isEditing,
      decoration: InputDecoration(
        labelText: lb,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
