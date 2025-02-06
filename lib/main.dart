import 'package:flutter/material.dart';
import 'package:notes_app/first_page.dart';
import 'package:notes_app/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  //initializing hive
  await Hive.initFlutter();
  //open the box
  var box=await Hive.openBox('notebox');
  runApp(const MyApp());


}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home:FirstPage()

    );
  }
}
