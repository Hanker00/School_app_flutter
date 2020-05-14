import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UserPosts extends StatefulWidget {
  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {

  DatabaseReference userPostsRef = FirebaseDatabase.instance.reference().child("Posts");


  List<UserPosts> userPostsList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}