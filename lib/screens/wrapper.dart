import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/authentication/authenticate.dart';
import 'package:school_project/screens/home/homepage.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/parentUI/parentHome.dart';
import 'package:school_project/screens/teacherUI/teacherHome.dart';
import 'package:school_project/shared/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    }
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
      builder: (BuildContext context, snapshot)
      {
        if (snapshot.hasData) {
          if (snapshot.data['role'] == "Student"){
            return Home();
          }
          else if(snapshot.data['role'] == "Parent")
          {
            return ParentHome();
          }
          else if(snapshot.data['role'] == "Teacher")
          {
            return TeacherHome();
          }
        else {
          return Home();
        }
        }
        else {
          return Loading();
        }
      },
    );
  }
}
