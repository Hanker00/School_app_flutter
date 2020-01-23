import 'package:cloud_firestore/cloud_firestore.dart';

class UserPost {
  final String id;
  final String imageUrl;
  final String subject;
  final String description;
  final String authorId;
  final Timestamp postDate;

  UserPost({this.id, this.imageUrl, this.subject, this.description, this.authorId, this.postDate});

  factory UserPost.fromDoc(DocumentSnapshot doc) {
    return UserPost(
      id: doc.documentID,
      imageUrl: doc['imageUrl'],
      subject: doc['subject'],
      description: doc['description'],
      authorId: doc['authorId'],
      postDate: doc['postDate'],

    );
  }
}