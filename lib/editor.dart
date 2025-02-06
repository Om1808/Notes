import 'package:flutter/material.dart';


class Editor extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final Function(String, String) saveTask;

  const Editor(
      {super.key,
      required this.titleController,
      required this.contentController,
      required this.saveTask});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4E1C1),
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
                        color: Color(0xffE4A74A),
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          titleController.clear();
                          contentController.clear();
                        }, icon: Icon(Icons.arrow_back),color: Color(0xff7D8F69), ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE4A74A),
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                        onPressed: () {
                          if (contentController.text.isNotEmpty) {
                            saveTask(titleController.text.trim(),
                                contentController.text.trim());
                            Navigator.of(context).pop();
                          } else {
                            final snack = SnackBar(
                              content: Text("Empty note can't be saved"),
                              action: SnackBarAction(
                                  label: 'Undo', onPressed: () {}),
                              duration: Duration(seconds: 10),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }
                        },
                        icon: Icon(
                          Icons.save,
                          color: Color(0xff7D8F69),
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
                    hintStyle:
                        TextStyle(color: Color(0xffC77459), fontSize: 32 , fontFamily: 'IBMPlexSerif-Regular'),
                    border: InputBorder.none),
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff3D2B1F),
                    fontFamily: 'IBMPlexSerif-Regular',
                    fontWeight: FontWeight.bold),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                cursorColor: Color(0xff3D2B1F),
              ),

              Expanded(
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                      hintText: "Type something",
                      hintStyle:
                          TextStyle(color: Color(0xffC77459), fontSize: 18 , fontFamily: 'IBMPlexSerif-Regular'),
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 16, color: Color(0xff3D2B1F) , fontFamily: 'IBMPlexSerif-Regular'),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Color(0xff3D2B1F),
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
