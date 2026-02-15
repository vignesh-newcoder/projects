import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskmate/util/database.dart';
import 'package:taskmate/util/dialog_box.dart';
import 'package:taskmate/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myboxx = Hive.box('mybox');

  @override
  void initState() {
    if (myboxx.get("TODOLIST") == null) {
      db.createtasks();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final controller = TextEditingController();

  ToDatabase db = ToDatabase();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.update();
  }

  void saveNewTask() {
    if (controller.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 164, 134, 234),
          content: Text(
            "Oops! forgot to type you're task",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(60)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      setState(() {
        db.toDoList.add(
          [
            controller.text,
            false,
          ],
        );
        controller.clear();
      });
      db.update();
    }
    Navigator.of(context).pop();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: controller,
          onSave: saveNewTask,
          oncancel: Navigator.of(context).pop,
        );
      },
    );
  }

  void deleTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasky',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 164, 134, 234),
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        onPressed: createTask,
        child: Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    'Add some Tasks',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 164, 134, 234),),
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  name: db.toDoList[index][0],
                  flag: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteItems: (context) => deleTask(index),
                );
              },
            ),
    );
  }
}
