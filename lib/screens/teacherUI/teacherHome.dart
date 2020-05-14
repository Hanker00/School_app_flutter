import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/models/parentChild.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/services/database.dart';
import 'package:school_project/screens/services/theme.dart';
import 'package:school_project/screens/teacherUI/teacherDashboard.dart';
import 'package:school_project/shared/loading.dart';
import 'package:school_project/screens/teacherUI/teacherAllStudents.dart';

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  int _currentTab = 0;
  PageController pageControllerTeacher;
  void initState() {
    // TODO: implement initState
    super.initState();
    pageControllerTeacher = PageController(initialPage: 0);
  }

  Widget buildBody(BuildContext context, DocumentSnapshot ds) {
    final user = Provider.of<User>(context);
    final userId = user.uid;
    final String studentId = ds.documentID;
    final String studentName = ds['name'];
    addParentChild() {
      ParentChild parentChild = ParentChild(
          childId: studentId, parentId: userId, childName: studentName);
      DatabaseService().parentAddChild(parentChild);
    }
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              addParentChild();
              pageControllerTeacher.animateToPage(
                1,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
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

  int currentTab = 0;
  final AuthService _auth = AuthService();
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DocumentReference currentUserCollection =
        Firestore.instance.collection('users').document(user.uid);
    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              body: PageView(
                controller: pageControllerTeacher,
                children: <Widget>[
                  Scaffold(
                    appBar: AppBar(
                      title: Text("Home"),
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
                    body: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Hello " + userData.name,
                              style: TextStyle(color: blueText, fontSize: 25.0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Divider(color: Colors.white),
                        InkWell(
                          onTap: () {
                            pageControllerTeacher.animateToPage(
                              2,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: purpleColor,
                              elevation: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  const ListTile(
                                    title: Text('View All Students',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0)),
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TeacherDashboard(),
                  //Page three
                  TeacherAllStudents(),
                ],
              onPageChanged: (int index) {
                  setState(() {
                    _currentTab = index;
                  });
                },
              ),
              bottomNavigationBar: CupertinoTabBar(
                  activeColor: purpleColor,
                  backgroundColor: mainColor,
                  currentIndex: _currentTab,
                  onTap: (int index) {
                    setState(() {
                      _currentTab = index;
                    });
                    pageControllerTeacher.animateToPage(
                      index,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                      Icons.home,
                      size: 32.0,
                    )),
                    BottomNavigationBarItem(
                        icon: Icon(
                      Icons.create,
                      size: 32.0,
                    )),
                    BottomNavigationBarItem(
                        icon: Icon(
                      Icons.assessment,
                      size: 32.0,
                    )),
                  ]),
            );
          }
          else {
            return Loading();
          }
        });
  }
}
