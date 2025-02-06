import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final bool taskCompleted;
  final String taskName;
  Function(bool?)? onChanged;

  TodoTile(
      {super.key,
      required this.taskCompleted,
      required this.onChanged,
      required this.taskName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 25, top: 20),
      child:Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff4F6D7A),
        ),
        child: Row(
          children: [
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.black,
              side: BorderSide(color: Colors.black),
            ),
            SizedBox(width: 5,),
            Text(
              taskName,
              style: TextStyle(
                  color: Color(0xffE0E0E0),
                  fontSize: 22,
                  fontFamily: 'IBMPlexSerif-Regular',
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            )
          ],
        ),
      )
    );
  }
}
