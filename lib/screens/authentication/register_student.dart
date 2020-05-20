import 'package:flutter/material.dart';

import 'package:numberpicker/numberpicker.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/shared/loading.dart';

class RegisterStudent extends StatefulWidget {
  final Function toggleView;
  RegisterStudent({this.toggleView});
  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  int grade = 8;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String name = "Name";
  String email = "";
  String password = "";
  String error = "";
  DateTime birthdate;
  String formattedDate;
  int _currentPage = 0;
  bool loading = false;
  Color purpleColor = Color.fromRGBO(155, 132, 255, 100);

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Student Register"),
      ),
      backgroundColor: mainColor,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          // Page one
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Center(
                      child: Text("Student Register",
                          style: TextStyle(color: blueText, fontSize: 25.0))),
                  SizedBox(height: 20.0),
                  Center(
                      child: Text("My name is...",
                          style: TextStyle(color: blueText, fontSize: 25.0))),
                  SizedBox(height: 20.0),
                  TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: name,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Enter a name please" : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      }),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: IconButton(
                          splashColor: Colors.transparent,
                          iconSize: 50.0,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: blueText,
                          ),
                          alignment: Alignment.center,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print(_pageController.page);
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // Page Two
          Container(
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context).textTheme.copyWith(
                      body1: Theme.of(context).textTheme.headline.copyWith(
                            color: Colors.white,
                          ),
                    ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Text("I am in grade:",
                      style: TextStyle(color: blueText, fontSize: 50.0)),
                  SizedBox(height: 20.0),
                  NumberPicker.integer(
                    initialValue: grade,
                    minValue: 0,
                    maxValue: 12,
                    onChanged: (new_grade) {
                      setState(() => grade = new_grade);
                    },
                  ),
                  SizedBox(height: 40.0),
                  IconButton(
                    iconSize: 50.0,
                    icon: Icon(
                      Icons.check_circle,
                      color: blueText,
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          // Final sign up button
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                Text(
                  "Is everything correct $name?",
                  style: TextStyle(color: blueText, fontSize: 50.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.0),
                Text(
                  "You are in grade: $grade",
                  style: TextStyle(color: blueText, fontSize: 50.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                IconButton(
                  iconSize: 50.0,
                  icon: Icon(
                    Icons.check_circle,
                    color: blueText,
                  ),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Text(
                    "Perfect $name!",
                    style: TextStyle(color: blueText, fontSize: 50.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    "Lastly please enter an Username and password",
                    style: TextStyle(color: blueText, fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 45.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Username",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (val) => val.isEmpty ? "Enter an Email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (val) => val.length < 6
                          ? "Enter a Password 6+ chars long"
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: purpleColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password, grade, name, "Student");
                          if (result == null) {
                            setState(() {
                              error = "please supply a valid email";
                              loading = false;
                            });
                          }
                        else {
                          return Navigator.of(context).pop();
                        }
                        }
                      
                      },
                      child: Text("Sign up",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
