import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  Reminder(DocumentSnapshot doc) {
    uid = doc['uid'];
    documentID = doc.id;
    title = doc['title'];
    imageURL = doc['imageURL'];
  }
  String uid;
  String documentID;
  String title;
  String imageURL;
}
