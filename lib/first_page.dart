import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Note/to_Do_Page.dart';
import 'home_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  final item = [Icon(Icons.home), Icon(FontAwesomeIcons.file)];
  int pageIndex=0;
  List pages=[
    HomePage(),
    ToDoPage()
  ];

  void navigateBottomBar(int index){
    setState(() {
      pageIndex=index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: item,
        height: 50,
        index: pageIndex,
        onTap: navigateBottomBar,
        backgroundColor: Color(0xffF4E1C1),
        buttonBackgroundColor: Color(0xffE4A74A),
        color: Color(0xffE4A74A),
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
