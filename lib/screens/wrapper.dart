import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/authentication/authenticate.dart';
import 'package:school_project/screens/home/homepage.dart';
import 'package:school_project/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}