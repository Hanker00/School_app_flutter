
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/models/parentChild.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/screens/parentUI/viewAllChildPosts.dart';
import 'package:school_project/screens/services/auth.dart';
import 'package:school_project/screens/services/database.dart';
import 'package:school_project/screens/services/theme.dart';
import 'package:school_project/shared/loading.dart';

class ViewChildrenFeed extends StatefulWidget {
  @override
  _ViewChildrenFeedState createState() => _ViewChildrenFeedState();
}

class _ViewChildrenFeedState extends State<ViewChildrenFeed> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final currentUser = Provider.of<User>(context);
    final String currentUserId = currentUser.uid.toString();

    getChildData(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new ListTile(title: new Text(doc["childId"]), subtitle: new Text(doc["parentId"].toString())))
        .toList();
  }

  return Scaffold(
    appBar: AppBar(
      title: Text("Your children"),
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
    body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('parents').document(currentUserId).collection("children").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.hasData);
          print(snapshot.data.documents.length);
          if (snapshot.data.documents.length > 0) 
          {
            print(snapshot.data.documents.length);
            return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
              buildBody(context, snapshot.data.documents[index]),
            );
          }
          else if (snapshot.data.documents.length == 0)  {
            print(snapshot.data.documents == 0);
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "It seems like you have yet to added any children",
                              style:
                                  TextStyle(color: blueText, fontSize: 25.0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Divider(color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Press the + sign on your navigation bar to add new Children",
                              style:
                                  TextStyle(color: blueText, fontSize: 25.0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                  ],
                ),
              );
            }
          }
          else {
            return Loading();
          }
      }
    ),
  );
}

Widget buildBody(BuildContext context, DocumentSnapshot ds) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewAllChildPosts(childId: ds['childId'], childName: ds['childName'],),),);
        },
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 124.0,
                decoration: new BoxDecoration(
                  color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(  
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                
                                ds['childName'],
                                style: TextStyle(color: blueText, fontSize: 20.0),
                              ),
                            ),
                            VerticalDivider(color: blueText,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),                             child: Center(child: Text("View Posts", style: TextStyle(color: blueText, fontSize: 20.0), textAlign: TextAlign.end,)),
                            )
                          ],
                        ),
                        
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}