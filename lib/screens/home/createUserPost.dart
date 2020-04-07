import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/models/userPostModel.dart';
import 'package:school_project/screens/home/homepage.dart';
import 'package:school_project/screens/home/userPosts.dart';
import 'package:school_project/screens/services/database.dart';
import 'package:school_project/shared/loading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CreateUserPost extends StatefulWidget {
  @override
  _CreateUserPostState createState() => _CreateUserPostState();
}

class _CreateUserPostState extends State<CreateUserPost> {
  @override
  Color purpleColor = Color.fromRGBO(155, 132, 255, 100);

  Color mainColor = Color.fromRGBO(0, 29, 38, 100);
  Color blueText = Color.fromRGBO(0, 207, 255, 100);
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String subject = "";
  PageController _pageControl;
  final _userFormKey = GlobalKey<FormState>();
  final _titleFormKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  String _description = "";
  String _title = "";
  DateTime currentDate = DateTime.now();
  File _imageFile;

  bool loading = false;

  final FirebaseStorage _storage =
    FirebaseStorage(storageBucket: "gs://school-app-flutter.appspot.com");
  
  StorageUploadTask _uploadTask;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
 @override
  void initState() {
    super.initState();
    _pageControl = PageController();
  }

  @override
  void dispose() {
    _pageControl.dispose();
    super.dispose();
  }

  Future<String> _startUpload() async {

    String userPostPhotoId = Uuid().v4();
    /// Unique file name for the file
    String filePath = 'images/posts/$userPostPhotoId.jpg';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_imageFile);
    });

    StorageTaskSnapshot storageSnap = await _uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }




  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);

      _uploadPost() async {
        
        //Create post
        setState(() {
          loading = true;
        });
        String imageUrl = null;
        if( _imageFile != null) {
          imageUrl = await _startUpload();
        }
        UserPost userPost = UserPost(
          imageUrl: imageUrl,
          subject: subject,
          description: _description,
          authorId: currentUser.uid,
          postDate: Timestamp.fromDate(DateTime.now()),
          );
          DatabaseService().createUserPost(userPost);
          setState(() {
            loading = false;
          });
        }

    return loading ? Loading() : Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          "Create a post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageControl,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          //Page 1
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Firstly, what subject would you like to make a post about?",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: blueText,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        iconSize: 30.0,
                        color: blueText,
                        onPressed: () {
                          print(_pageControl.page);
                          _pageControl.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            subject = "Physics";
                          });
                        
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.text_fields,
                        ),
                        iconSize: 30.0,
                        color: blueText,
                        onPressed: () {
                          _pageControl.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            subject = "English";
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.all_inclusive,
                        ),
                        iconSize: 30.0,
                        color: blueText,
                        onPressed: () {
                          _pageControl.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            subject = "Math";
                          });
                        },
                      )
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Physics",
                        style: TextStyle(fontSize: 20.0, color: blueText),
                      ),
                      Text(
                        "English",
                        style: TextStyle(fontSize: 20.0, color: blueText),
                      ),
                      Text(
                        "Math",
                        style: TextStyle(fontSize: 20.0, color: blueText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Page two
          Container(
            child: Form(
              key: _userFormKey,
              child: Column(
                children: <Widget>[
                  Text(subject, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: blueText)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Secondly, would you like to write something that you did?",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: blueText,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      maxLength: 280,
                      
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: blueText),
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: blueText),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blueText),
                        ),
                        fillColor: purpleColor,
                        hintText: "Todays lesson was...",
                        hintStyle: TextStyle(color: blueText),
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Enter a description please" : null,
                      onChanged: (val) {
                        setState(() => _description = val);
                      }),
                    ),
                  SizedBox(height: 40.0),
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: purpleColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          if (_userFormKey.currentState.validate()) {
                          
                          _pageControl.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } 
                        },
                        child: Text("Next",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
          ),

          //Page 3
          Container(
            child: Form(
              key: _titleFormKey,
              child: Column(
                children: <Widget>[
                  Text(subject, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: blueText)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Choose an appropriate title for your post",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: blueText,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 1,
                      style: TextStyle(color: blueText),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: blueText),
                        ),
                        fillColor: purpleColor,
                        hintText: "Title",
                        hintStyle: TextStyle(color: blueText),
                      ),
                      validator: (val) =>
                          val.isEmpty ? "Enter a title please" : null,
                      onChanged: (val) {
                        setState(() => _title = val);
                      }),
                    ),
                  SizedBox(height: 40.0),
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: purpleColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                          if (_titleFormKey.currentState.validate()) {
                          
                          _pageControl.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }; 
                        },
                        child: Text("Next",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
          ),

          //Page 4
          Container(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Lastly, would you like to add an image to your post? If not press the next button",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: blueText,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                if (_imageFile != null)
                    Image(
                      width: MediaQuery.of(context).size.width,
                      height: 330.0,
                      image: FileImage(_imageFile),
                      fit: BoxFit.cover,
                    ),
                  IconButton(
                    icon: Icon(Icons.camera),
                    iconSize: 30.0,
                    color: purpleColor,
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                SizedBox(height: 20.0),
                Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: purpleColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                          _pageControl.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            ); 
                        },
                        child: Text("Next",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
              ],
            ),
          ),

          //Page 5
          Container(
            child: Column(
              children: <Widget>[
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        subject + " " + formattedCurrentDate,
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
                        _title,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: blueText,
                        ),
                      ),
                    ),
                  ),
                  if (_imageFile != null) 
                    Image(
                      width: MediaQuery.of(context).size.width,
                      height: 330.0,
                      image: FileImage(_imageFile),
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
                          _description,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: blueText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: purpleColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                          _uploadPost();
                        },
                        child: Text("Post",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
