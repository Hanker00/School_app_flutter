import 'package:flutter/material.dart';
import 'package:school_project/screens/authentication/register_parent.dart';
import 'package:school_project/screens/authentication/register_student.dart';
import 'package:school_project/screens/authentication/register_teacher.dart';
import 'package:school_project/screens/services/theme.dart';




class SignUpSelection extends StatefulWidget {

  final Function toggleView;
  SignUpSelection({this.toggleView});

  @override
  _SignUpSelectionState createState() => _SignUpSelectionState();
}

class _SignUpSelectionState extends State<SignUpSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Center(
                child: Text(
                  "I am a...",
                  style: TextStyle(
                    fontSize: 60.0,
                    color: blueText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            // Student
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: purpleColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  return Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => RegisterStudent()
                    )
                  );
                },
                child: Text("Student",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 30.0),
            // Parent
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: purpleColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  return Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => RegisterParent())
                    );
                },
                child: Text("Parent",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(height: 30.0),
            // Teacher
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: purpleColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  return Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => TeacherRegister())
                    );
                },
                child: Text("Teacher",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),

            SizedBox(height: 30.0),
            InkWell(
              child: Text(
                "I Already Have an Account",
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
    );
  }
}

class RegisterTeacher {
}
