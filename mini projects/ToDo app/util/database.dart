import 'package:hive/hive.dart';

class ToDatabase {
  List toDoList = [];
   
   final boxx=Hive.box("mybox");

  void createtasks() {
    toDoList = [
      ["Make Home Work", false],
      ["Do Excercise", false],
    ];
  }
  void loadData(){
    toDoList=boxx.get("TODOLIST");
  }

  void update(){
    boxx.put("TODOLIST",toDoList);
  }
  
}
