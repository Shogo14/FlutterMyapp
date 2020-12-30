import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
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

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) throw ('タイトルを入力してください');
    final imageURL = await _uploadImage();
    await FirebaseFirestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'imageURL': imageURL,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateBook(Book book) async {
    if (bookTitle.isEmpty) throw ('タイトルを入力してください');

    final imageURL = await _uploadImage();
    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);

    await document.update(
      {
        'title': bookTitle,
        'imageURL': imageURL,
        'updateAt': Timestamp.now(),
      },
    );
  }

  Future<String> _uploadImage() async {
    firebase_storage.TaskSnapshot snapshot = await firebase_storage
        .FirebaseStorage.instance
        .ref('books/$bookTitle')
        .putFile(imageFile);

    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
