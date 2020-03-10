import 'package:flutter/material.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/services/theme.dart';
import 'package:school_project/shared/loading.dart';

class RegisterParent extends StatefulWidget {
  @override
  _RegisterParentState createState() => _RegisterParentState();
}

class _RegisterParentState extends State<RegisterParent> {
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
  String name = "Name";
  String email = "";
  String error = "";
  String password = "";
  int grade = 0;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Parent Register"),
      ),
      backgroundColor: mainColor,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[

          // Page One
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Center(
                      child: Text("Parent Register",
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
                              .registerWithEmailAndPassword(email, password, grade, name, "Parent");
                          if (result == null) {
                            setState(() {
                              error = "please supply a valid email";
                              loading = false;
                            });
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
      ),
    );
  }
}