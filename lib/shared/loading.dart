import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  
  Color mainColor = Color.fromRGBO(0, 29, 38, 100);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}