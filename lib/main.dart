import 'package:flutter/material.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'screens/services/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: mainDarkTheme(),
          home: Wrapper(),
      ),
    );
  }
}
