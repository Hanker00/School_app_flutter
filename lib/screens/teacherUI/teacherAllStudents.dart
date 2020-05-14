import 'package:flutter/material.dart';
import 'package:school_project/screens/services/theme.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_project/shared/loading.dart';
import 'package:school_project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/parentUI/viewAllChildPosts.dart';

class TeacherAllStudents extends StatefulWidget {
  @override
  _TeacherAllStudentsState createState() => _TeacherAllStudentsState();
}

Widget buildBody(BuildContext context, DocumentSnapshot ds) {
  final user = Provider.of<User>(context);
  final userId = user.uid;
    final String studentId = ds.documentID;
    final String studentName = ds['name'];

    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAllChildPosts(childId: studentId, childName: studentName,),),);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 124.0,
              decoration: new BoxDecoration(
                color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            ds['name'],
                            style: TextStyle(color: blueText, fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }



class _TeacherAllStudentsState extends State<TeacherAllStudents> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
                    appBar: AppBar(
                      title: Text("View Students"),
                      backgroundColor: mainColor,
                      actions: <Widget>[
                        FlatButton.icon(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await _auth.signOut();
                          },
                        ),
                      ],
                    ),
                    body: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('users')
                                  .where("role", isEqualTo: "Student")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemExtent: 80.0,
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (context, index) => buildBody(
                                        context,
                                        snapshot.data.documents[index]),
                                  );
                                } else {
                                  return Loading();
                                }
                              }),

                  );
  }
}