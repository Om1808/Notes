import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  VoidCallback saveTask;

  Editor(
      {super.key,
      required this.titleController,
      required this.contentController,
      required this.saveTask});

  @override
  Widget build(BuildContext context) {
    var myTitleFont = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );
    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              //Custom App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          contentController.clear();
                          titleController.clear();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff3b3b3b),
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                        onPressed: () {
                          if (contentController.text.isNotEmpty) {
                            saveTask();
                            Navigator.of(context).pop();
                          } else {
                            final snack = SnackBar(
                              content: Text("Empty note can't be saved"),
                              action: SnackBarAction(
                                  label: 'Undo', onPressed: () {}),
                              duration: Duration(seconds: 10),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }
                        },
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 30),
                    border: InputBorder.none),
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white,
              ),

              Expanded(
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                      hintText: "Type something",
                      hintStyle:
                          TextStyle(color: Colors.grey[400], fontSize: 15),
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.white,
                  enableSuggestions: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
