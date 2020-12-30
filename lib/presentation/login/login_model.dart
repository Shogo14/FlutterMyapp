import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future login() async {
    if (mail.isEmpty) throw ('メールアドレスを入力してください');
    if (password.isEmpty) throw ('パスワードを入力してください');

    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: mail, password: password);
    final uid = result.user.uid;
    // TODO 端末に保存して使う
  }
}
