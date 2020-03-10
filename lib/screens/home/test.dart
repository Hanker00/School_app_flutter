import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/authentication/authenticate.dart';
import 'package:school_project/screens/home/homepage.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
      builder: (BuildContext context, snapshot)
      {
        if (user == null) {
          return Authenticate();
        }
        else if (snapshot.hasData) {
          if (snapshot.data['role'] == "Student"){
            return Home();
          }
        }
      },
    );
  }
}