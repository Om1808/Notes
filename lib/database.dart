import 'package:hive_flutter/hive_flutter.dart';

class NotesDB{


  final notesBox=Hive.box('notebox');
  List entries =[];
  List tasks =[];




  void createInitialData(){
    entries=[
      ["Welcome to Notes" , "This is my Notes App in Flutter"]
    ];
  }

  void createInitialToDo(){
    tasks=[
      ["Create Task" , false]

    ];
  }
  void loadToDo(){
    tasks=notesBox.get("ToDoTask");
  }
  void updateToDo(){
    notesBox.put("ToDoTask", tasks);

  }

  void loadData(){
    entries=notesBox.get("Note");
  }

  void updateDataBase(){

    notesBox.put("Note", entries);
    loadData();
  }



}