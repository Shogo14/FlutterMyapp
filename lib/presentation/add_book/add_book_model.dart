import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    final bookRef = await FirebaseFirestore.instance.collection('books').add(
      {
        'title': bookTitle,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future updateBook(Book book) async {
    if (bookTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    final document =
        FirebaseFirestore.instance.collection('books').doc(book.documentID);

    await document.update(
      {
        'title': bookTitle,
        'updateAt': Timestamp.now(),
      },
    );
  }
}
