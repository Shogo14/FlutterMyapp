import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  User _user;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future signUp() async {
    if (mail.isEmpty) throw ('メールアドレスを入力してください');
    if (password.isEmpty) throw ('パスワードを入力してください');

    UserCredential userCredential;
    try {
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    final email = userCredential.user.email;
    final uid = userCredential.user.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'uid': uid,
        'email': email,
        'createdAt': Timestamp.now(),
      },
    );
  }

  Future currentUser() async {
    final _currentUser = _firebaseAuth.currentUser;
    if (_currentUser != null) {
      _user = _currentUser;
      notifyListeners();
    }
  }
}
