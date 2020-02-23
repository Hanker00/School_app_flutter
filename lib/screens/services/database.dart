import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_project/models/user.dart';
import 'package:school_project/models/userPostModel.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });
  // collection reference
  final userPostsRef = Firestore.instance.collection('posts');
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(int grade, String name, String school, String role) async {
    return await userCollection.document(uid).setData({
      'grade': grade,
      'name': name,
      'school': school,
      'role': role,
    });
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      grade: snapshot.data['grade'],
      school: snapshot.data['school'],
      role: snapshot.data['role'],
    );
  }


  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  void createUserPost(UserPost userPost) {
    userPostsRef.document(userPost.authorId).collection('userPosts').add({
      'imageUrl': userPost.imageUrl,
      'subject': userPost.subject,
      'description': userPost.description,
      'authorId': userPost.authorId,
      'postDate': userPost.postDate,
    });
  }
}