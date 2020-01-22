import 'package:flutter/material.dart';

class StudentRegThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color purpleColor = Color.fromRGBO(155, 132, 255, 100);

  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Student"),
          ],
        ),
      ),
    );
  }
}