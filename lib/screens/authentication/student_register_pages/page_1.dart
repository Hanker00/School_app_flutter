import 'package:flutter/material.dart';

class StudentRegOne extends StatefulWidget {
  @override
  _StudentRegOneState createState() => _StudentRegOneState();
}

class _StudentRegOneState extends State<StudentRegOne> {
  @override
  Color purpleColor = Color.fromRGBO(155, 132, 255, 100);
  String name = "";
  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        
      ),
    );
  }
}
