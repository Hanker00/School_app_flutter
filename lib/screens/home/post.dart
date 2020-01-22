import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:school_project/screens/home/homepage.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  File sampleImage;
  final formKey = GlobalKey<FormState>();
  String _myValue;
  String url;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave()
  {
    final form = formKey.currentState;

    if(form.validate())
    {
      form.save();
      return true;
    }
    else
    {
      return false;
    }
  }

  void uploadStatusPost() async 
  {
    if(validateAndSave())
    {
      final StorageReference studentPostRef = FirebaseStorage.instance.ref().child("Student Posts");

      var timeKey = DateTime.now();

      final StorageUploadTask uploadTask = studentPostRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      var PostUrl = await  (await uploadTask.onComplete).ref.getDownloadURL();

      url = PostUrl.toString();

      print("Post Url = " + url);

      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url)
  {
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat("MMM, d, yyyy");
    var formatTime = DateFormat("EEEE, hh:mm aaa");

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();

    var postData = 
    {
      "image": url,
      "description": _myValue,
      "date": date,
      'time': time,
    };

    databaseRef.child("Posts").push().set(postData);
  }

  void goToHomePage()
  {
    Navigator.push
    (
      context,
      MaterialPageRoute(builder: (context)
      {
        return Home();
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a post"),
        centerTitle: true,
      ),
      body: Center(
        child: sampleImage == null
            ? Text("Would you like to upload an image with your post?")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: 330.0,
              width: 660.0,
            ),
            SizedBox(height: 15.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value.isEmpty ? 'Description is required' : null;
              },
              onSaved: (value) {
                return _myValue = value;
              },
            ),
            SizedBox(height: 15.0),

            RaisedButton(
              elevation: 10.0,
              child: Text("Add a new post"),
              textColor: Colors.white,
              color: Colors.pink,

              onPressed: uploadStatusPost,
            )
          ],
        ),
      ),
    );
  }
}
