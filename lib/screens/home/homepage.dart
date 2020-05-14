import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/home/createUserPost.dart';
import 'package:school_project/screens/home/userPostView.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/services/database.dart';
import 'package:school_project/models/user.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  final AuthService _auth = AuthService();
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
    return currentYear.toString() + " " + currentMonthInString +
        " " +
        currentDay.toString();
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
                      title: Text("Sharecify", style: TextStyle(fontFamily: "Playfairdisplay")),  
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
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          InkWell(
                            onTap: () {
                              _pageController.animateToPage(
                                1,
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
                                onPressed: () {
                                  print(DefaultTextStyle.of(context).style.fontFamily);
                                  _pageController.animateToPage(
                                    3,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
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
                  CreateUserPost(),
                  UserPostView(), 
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
          } else {
            return Scaffold(
              body: Text("Error occured"),
            );
          }
        });
  }
}
