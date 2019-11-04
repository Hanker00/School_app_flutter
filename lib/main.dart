import 'package:flutter/material.dart';
import 'package:school_project/pages/login.dart';
import 'package:school_project/pages/homepage.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Login(),
    '/home': (context) => Home(),
  },
));
