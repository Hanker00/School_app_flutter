import 'package:flutter/material.dart';

Color purpleColor = Color.fromRGBO(155, 132, 255, 100);
Color mainColor = Color.fromRGBO(0, 29, 38, 100);
Color blueText = Color.fromRGBO(0, 207, 255, 100);
TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
String mainFont = 'Montserrat';
ThemeData mainDarkTheme() {
  
  final ThemeData base = ThemeData(
    primaryColor: Colors.black,
    buttonColor: purpleColor,
    primaryColorDark: blueText,
    scaffoldBackgroundColor: mainColor,
    backgroundColor: mainColor,
    fontFamily: mainFont,
  );

  return base.copyWith(
    textTheme: mainTextTheme(base.textTheme),
    primaryTextTheme: mainTextTheme(base.primaryTextTheme),
    accentTextTheme: mainTextTheme(base.accentTextTheme)
  );
}

TextTheme mainTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(
      fontFamily: mainFont,
      color: Colors.white,
    ),
    headline: base.headline.copyWith(

    )
  );
}