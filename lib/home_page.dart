import 'package:flutter/material.dart';
import 'package:notes_app/editor.dart';
import 'package:notes_app/note_tile.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController noteController = TextEditingController();
  Map < dynamic , dynamic> entries={};
  List<Color> colors = [];

  Color getRandomColor() {
    final colors = [
      Colors.red[300],
      Colors.blue[300],
      Colors.green[300],
      Colors.orange[300],
      Colors.purple[300],
      Colors.teal[300],
      Colors.pink[300],
      Colors.amber[300],
      Colors.cyan[300],
      Colors.lime[300],
      Colors.deepPurple[300],
    ];
    final random = Random();
    return colors[random.nextInt(colors.length)]!;
  }

  void buildTile() {
    setState(() {
      entries.add(titleController.text.trim());
      colors.add(getRandomColor());
      contentController.clear();
      titleController.clear();
    });
  }

  var myTitleFont = TextStyle(
    color: Colors.white,
    fontSize: 30,
  );

  //Text Editing Controllers Title & Content
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  //variable for general font style
  var myWhiteFont = TextStyle(color: Colors.white, fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: SafeArea(
        // Custom App bar
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                children: [
                  Text(
                    "Notes",
                    style: myTitleFont,
                  ),
                  Spacer(),

                  //Search Button
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  //Information button
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            entries.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Press + to add new note",
                        style: myWhiteFont,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Editor(
                                          titleController:
                                              TextEditingController(
                                                  text: entries[index]),
                                          contentController:
                                              TextEditingController(
                                                  text: entries[index]),
                                          saveTask:buildTile)));
                            },
                            child: NoteTile(
                                name: entries[index], tileColor: colors[index]),
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
                    saveTask: buildTile,
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
        child: Icon(Icons.add),
      ),
    );
  }
}
