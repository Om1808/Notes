import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String name;
  final Color tileColor;
  const NoteTile({super.key, required this.name, required this.tileColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35, right: 25, top: 20),
      child: Card(
        color: tileColor,
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Text(
            name,
            style: TextStyle(
              color: Color(0xffE0E0E0),
              fontSize: 26,
              fontFamily: 'IBMPlexSerif-Regular',
            ),
          ),
        ),
      ),
    );
  }
}
