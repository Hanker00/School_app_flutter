import 'package:flutter/material.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/authentication/login.dart';
import 'package:school_project/screens/home/homepage.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}
