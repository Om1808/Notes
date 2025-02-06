import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Note/todo_Tile.dart';
import 'package:notes_app/database.dart';
import 'package:notes_app/dialog_box.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _NotePageState();
}

class _NotePageState extends State<ToDoPage> {
  final notesBox = Hive.box('notebox');
  NotesDB db = NotesDB();
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (notesBox.get("ToDoTask") == null) {
      db.createInitialToDo();
    } else {
      db.loadToDo();
    }
  }

  void deleteTile(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.updateToDo();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = !db.tasks[index][1];
    });
    db.updateToDo();
  }

  void saveTask(){
    setState(() {
      db.tasks.add([taskController.text.trim() , false]);
      taskController.clear();
    });
    db.updateToDo();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Color(0xffF4C7AB),
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: taskController,
                      decoration: InputDecoration(
                          hintText: "Enter Task",
                          hintStyle: TextStyle(
                              color: Color(0xffC77459),
                              fontSize: 18,
                              fontFamily: 'IBMPlexSerif-Regular'),
                          border:OutlineInputBorder()),
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff3D2B1F),
                          fontFamily: 'IBMPlexSerif-Regular'),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Color(0xff3D2B1F),
                      enableSuggestions: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //cancel Button
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Color(0xffC75C5C),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontFamily: 'IBMPlexSerif-Regular',
                                color: Color(0xffFFF7E6)),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        //delete Button
                        MaterialButton(
                          onPressed: (){
                             saveTask();
                            Navigator.of(context).pop();
                          },
                          color: Color(0xffC75C5C),
                          child: Text("Save",
                              style: TextStyle(
                                  fontFamily: 'IBMPlexSerif-Regular',
                                  color: Color(0xffFFF7E6))),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  var myTitleFont = TextStyle(
      color: Color(0xffD95D39),
      fontSize: 32,
      fontFamily: 'Pacifico-Regular',
      shadows: [
        Shadow(
          offset: Offset(0.0, 0.0),
          blurRadius: 10.0,
          color: Color(0xffE4A74A).withOpacity(0.8),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4E1C1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "TO DO",
                    style: myTitleFont,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Divider(),
              ),
              SizedBox(
                height: 15,
              ),
              db.tasks.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "Press + to add new Task",
                          style: TextStyle(
                              fontFamily: 'IBMPlexSerif-Regular',
                              fontSize: 28,
                              color: Color(0xff3D2B1F)),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: db.tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                            deleteNote: () {
                                              deleteTile(index);
                                            },
                                          ));
                                },
                                child: TodoTile(
                                    taskCompleted: db.tasks[index][1],
                                    onChanged: (value) =>
                                        checkBoxChanged(value, index),
                                    taskName: db.tasks[index][0]));
                          }),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        elevation: 10,
        shape: CircleBorder(),
        backgroundColor: Color(0xffE4A74A),
        child: FaIcon(
          FontAwesomeIcons.featherPointed,
          color: Color(0xff7D8F69),
        ),
      ),
    );
  }
}
