import 'package:flutter/material.dart';







class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  Color purpleColor = Color.fromRGBO(155, 132, 255, 100);

  final emailField = TextField(
    obscureText: false,
    style: TextStyle(
      color: Colors.white,
    ),
    decoration: InputDecoration(
        prefixStyle: TextStyle(
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder:
        OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(32.0))),
  );

  final passwordField = TextField(
    obscureText: false,
    style: TextStyle(
      color: Colors.white,
    ),
    decoration: InputDecoration(
        prefixStyle: TextStyle(
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder:
        OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(32.0))),
  );


  @override
  Widget build(BuildContext context) {

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: purpleColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/home");
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        backgroundColor: mainColor,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: ListView(
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
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(height: 35.0),
                  loginButon,
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
                      print("hello");
                    },
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}