import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/authentication/register_student.dart';
import 'package:school_project/screens/home/createUserPost.dart';
import 'package:school_project/screens/home/post.dart';
import 'package:school_project/screens/home/userPosts.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/services/database.dart';
import 'package:school_project/models/user.dart';

import 'destination.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  final AuthService _auth = AuthService();
  int _currentIndex = 0;
  Color purpleColor = Color.fromRGBO(155, 132, 255, 100);

  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  PageController _pageController;

  String todayDate() {
    DateTime now = DateTime.now();
    int currentMonth = now.month - 1;
    int currentDay = now.day;
    int currentYear = now.year;
    List monthInString = [
      "January",
      "February",
      "Mars",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    String currentMonthInString = monthInString[currentMonth];
    return currentMonthInString +
        " " +
        currentDay.toString() +
        " " +
        currentYear.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DocumentReference currentUserCollection =
        Firestore.instance.collection('users').document(user.uid);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              backgroundColor: mainColor,
              body: PageView(
                controller: _pageController,
                children: <Widget>[
                  Scaffold(
                    backgroundColor: mainColor,
                    appBar: AppBar(
                      title: Text("Sharecify"),
                      elevation: 0.0,
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
                    body: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userData.name,
                                  style: TextStyle(
                                      color: blueText, fontSize: 25.0),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                todayDate(),
                                style: TextStyle(
                                  color: blueText,
                                  fontSize: 40.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "What have you accomplished today?",
                                style: TextStyle(
                                  color: blueText,
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UploadPost();
                              }));
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
                                      title: Text(
                                          'Create a post about what you did today...',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0)),
                                    ),
                                    SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.create,
                                          size: 70.0,
                                        ),
                                        Icon(
                                          Icons.add,
                                          size: 70.0,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: purpleColor,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () {},
                                child: Text("See previous post",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  UploadPost(),
                  CreateUserPost(),
                  RegisterStudent(), 
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
                    _pageController.animateToPage(
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
                      Icons.account_circle,
                      size: 32.0,
                    )),
                    BottomNavigationBarItem(
                        icon: Icon(
                      Icons.assessment,
                      size: 32.0,
                    )),
                    BottomNavigationBarItem(
                        icon: Icon(
                      Icons.create,
                      size: 32.0,
                    )),
                  ]),
            );
          } else {
            return Scaffold(
              body: Text("Error occured"),
            );
          }
        });
  }
}
