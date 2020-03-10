import 'package:cloud_firestore/cloud_firestore.dart';

class ParentChild {
  final String parentId;
  final String childId;
  final String childName;
  ParentChild({this.parentId, this.childId, this.childName});


}

class ChildData {
  final String parentId;
  final String childId;
  final String childName;
  ChildData({ this.parentId, this.childId, this.childName});
}