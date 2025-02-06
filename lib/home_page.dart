import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/Note/to_Do_Page.dart';
import 'package:notes_app/database.dart';
import 'package:notes_app/dialog_box.dart';
import 'package:notes_app/editor.dart';
import 'package:notes_app/note_tile.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = [];
  //reference the box
  final notesBox = Hive.box('notebox');
  NotesDB db = NotesDB();
  Color getRandomColor() {
    final colors = [
      Color(0xff4F6D7A),
    ];
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  @override
  void initState() {
    super.initState();
    if (notesBox.get("Note") == null) {
      db.createInitialData();
      colors.add(getRandomColor());
    } else {
      db.loadData();
    }
    _updateColors();
  }

  void _updateColors() {
    // Ensure colors list matches the length of db.entries
    while (colors.length < db.entries.length) {
      colors.add(getRandomColor());
    }
    while (colors.length > db.entries.length) {
      colors.removeLast();
    }
  }

  void buildTile(String title, String content) {
    setState(() {
      db.entries.add([title, content]);
      colors.add(getRandomColor());
      contentController.clear();
      titleController.clear();
    });
    db.updateDataBase();
  }

  void updateTile(int index, String newTitle, String newContent) {
    setState(() {
      db.entries[index] = [newTitle, newContent];
      _updateColors();
    });
    db.updateDataBase();
  }

  void deleteTile(int index) {
    setState(() {
      db.entries.removeAt(index);
    });
    db.updateDataBase();
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

  //Text Editing Controllers Title & Content
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  //variable for general font style
  var myContentFont = TextStyle(
      color: Colors.white, fontSize: 15, fontFamily: 'IBMPlexSerif-Regular');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4E1C1),
      body: SafeArea(
        // Custom App bar
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notes",
                    style: myTitleFont,
                  ),
                  //Search Button
                  //Information button
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE4A74A),
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xff7D8F69),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(),
            ),
            SizedBox(
              height: 10,
            ),
            db.entries.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Press + to add new note",
                        style: TextStyle(
                            fontFamily: 'IBMPlexSerif-Regular',
                            fontSize: 28,
                            color: Color(0xff3D2B1F)),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: db.entries.length,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Editor(
                                          titleController:
                                              TextEditingController(
                                                  text: db.entries[index][0]),
                                          contentController:
                                              TextEditingController(
                                                  text: db.entries[index][1]),
                                          saveTask: (String newTitle,
                                              String newContent) {
                                            updateTile(
                                                index, newTitle, newContent);
                                          })));
                            },
                            child: NoteTile(
                                name: db.entries[index][0],
                                tileColor: colors[index]),
                          );
                        }),
                  )
          ],
        ),
      ),

      // add note Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => Editor(
                    saveTask: (String newTitle, String newContent) {
                      buildTile(newTitle, newContent);
                    },
                    contentController: contentController,
                    titleController: titleController,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                //Tween for outgoing Page
                final outgoingScaleTween = Tween<double>(begin: 1.0, end: 0.0);
                final outgoingOffsetTween =
                    Tween<Offset>(begin: Offset.zero, end: Offset(0.5, 0.5));

                //Tween for incoming Page
                final incomingScaleTween = Tween<double>(begin: 0.0, end: 1.0);
                final incomingOffsetTween =
                    Tween<Offset>(begin: Offset(0.5, 0.5), end: Offset.zero);

                return Stack(
                  children: [
                    SlideTransition(
                      position: secondaryAnimation.drive(outgoingOffsetTween),
                      child: ScaleTransition(
                        scale: ReverseAnimation(secondaryAnimation)
                            .drive(outgoingScaleTween),
                        child: HomePage(),
                      ),
                    ),
                    SlideTransition(
                      position: animation.drive(incomingOffsetTween),
                      child: ScaleTransition(
                        scale: animation.drive(incomingScaleTween),
                        child: child,
                      ),
                    )
                  ],
                );
              }));
        },
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
