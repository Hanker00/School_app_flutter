import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_project/models/userPostModel.dart';

class ViewUserPost extends StatelessWidget {

  final DocumentSnapshot userPost;
  ViewUserPost({Key key, @required this.userPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color.fromRGBO(0, 29, 38, 100);
    Color blueText = Color.fromRGBO(0, 207, 255, 100);
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    var date = userPost['postDate'].toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return Scaffold(
            backgroundColor: mainColor,
            appBar: AppBar(
              backgroundColor: mainColor,
              centerTitle: true,
              title: Text(
                userPost['subject'].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        userPost['subject'] + " " + formattedDate,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: blueText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        userPost['subject'],
                        style: TextStyle(
                          fontSize: 20.0,
                          color: blueText,
                        ),
                      ),
                    ),
                  ),
                  if (userPost['imageUrl'] != null) 
                    FadeInImage.assetNetwork(
                      placeholder: "assets/loading.gif",
                      width: MediaQuery.of(context).size.width,
                      height: 330.0,
                      image: userPost['imageUrl'],
                      fit: BoxFit.cover,
                    ),

                  SizedBox(height: 20.0),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: BorderSide(color: blueText)),
                      color: mainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userPost['description'],
                          style: TextStyle(
                            fontSize: 20.0,
                            color: blueText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
              ],
            ),
          );
  }
}