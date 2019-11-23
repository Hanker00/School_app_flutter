import 'package:flutter/material.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/shared/loading.dart';


class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Color purpleColor = Color.fromRGBO(155, 132, 255, 100);


  @override
  Widget build(BuildContext context) {

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: purpleColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            setState(() => loading = true);
            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
            if(result == null) {
              setState(() {
                error = "Could not sign in with those credentials";
                loading = false;
              });
            }
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: mainColor,
        body: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Text(
                        "Sharecify",
                        style: TextStyle(
                          fontSize: 60.0,
                          color: blueText,
                        ),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          validator: (val) => val.length < 6 ? "Enter a Password 6+ chars long" : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                      ),
                      SizedBox(height: 35.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: loginButon,
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        error,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(height: 25.0),
                      InkWell(
                        child: Text(
                          "New here?",
                          style: TextStyle(
                            color: blueText,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,

                        ),
                        onTap: () {
                          widget.toggleView();
                        },
                      ),
                    ],
                  ),
                ),
              ],
          ),
          ),
      )
    );
  }
}