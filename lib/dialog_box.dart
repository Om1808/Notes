//Dialog Box
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  VoidCallback deleteNote;
   DialogBox({
    super.key,
    required this.deleteNote
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffF4C7AB),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Are you sure you want to delete this Note",
              style: TextStyle(
                  fontFamily: 'IBMPlexSerif-Regular',
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            //save + cancel button
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
                    deleteNote();
                    Navigator.of(context).pop();
                  },
                  color: Color(0xffC75C5C),
                  child: Text("Delete",
                      style: TextStyle(
                          fontFamily: 'IBMPlexSerif-Regular',
                          color: Color(0xffFFF7E6))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
