import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_project/screens/parentUI/viewAllChildPosts.dart';
import 'package:school_project/screens/services/theme.dart';
import 'package:school_project/shared/loading.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

      
class _TeacherDashboardState extends State<TeacherDashboard> {
  String numberOfStudents = "Loading...";
  String numberOfParents = "Loading...";
  bool loading = true;

  // Function to calculate all total users with the role Student
  Future<String> calculateAllStudents() async {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("users").where("role", isEqualTo: "Student").getDocuments();
        var list = querySnapshot.documents;
        print(list.length);
        return list.length.toString();
  }

  // Function to calculate all total users with the role Parents
  Future<String> calculateAllParents() async {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("users").where("role", isEqualTo: "Parent").getDocuments();
        var list = querySnapshot.documents;
        print(list.length);
        return list.length.toString();
  }
  _TeacherDashboardState() {
      calculateAllStudents().then((val) => setState(() {
            numberOfStudents = val;
          }));
      calculateAllParents().then((val) => setState(() {
            numberOfParents = val;
          }));
          loading = false;
    }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
          backgroundColor: mainColor,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: purpleColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("Total number of students:"),
                        subtitle: Text(numberOfStudents),
                        leading: Icon(Icons.person),
                      ),
                          FlatButton(
                            child: Text("View all students"),
                            textColor: blueText,
                            onPressed: () {
                              
                            },
                          ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: purpleColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("Total number of Parents"),
                        subtitle: Text(numberOfParents),
                        leading: Icon(Icons.person),
                      ),
                          FlatButton(
                            child: Text("View all Parents"),
                            textColor: blueText,
                            onPressed: () {

                            },
                          ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}