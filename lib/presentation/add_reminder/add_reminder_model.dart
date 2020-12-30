import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/domain/reminder.dart';

class AddReminderModel extends ChangeNotifier {
  String title = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  // ignore: missing_return
  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addReminder() async {
    if (title.isEmpty) throw ('タイトルを入力してください');
    final imageURL = await _uploadImage();
    await FirebaseFirestore.instance.collection('reminders').add(
      {
        'title': title,
        'imageURL': imageURL,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateReminder(Reminder reminder) async {
    if (title.isEmpty) throw ('タイトルを入力してください');

    final imageURL = await _uploadImage();
    final document = FirebaseFirestore.instance
        .collection('reminders')
        .doc(reminder.documentID);

    await document.update(
      {
        'title': title,
        'imageURL': imageURL,
        'updateAt': Timestamp.now(),
      },
    );
  }

  Future<String> _uploadImage() async {
    firebase_storage.TaskSnapshot snapshot = await firebase_storage
        .FirebaseStorage.instance
        .ref('reminders/$title')
        .putFile(imageFile);

    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
