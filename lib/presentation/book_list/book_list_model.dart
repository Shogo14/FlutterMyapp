import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/domain/book.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final bookRef = await FirebaseFirestore.instance.collection('books').get();
    final books = bookRef.docs.map((doc) => Book(doc)).toList();
    this.books = books;
    notifyListeners();
  }
}
