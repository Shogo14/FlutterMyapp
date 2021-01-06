import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/login/login_page.dart';
import 'package:myapp/presentation/reminder_list/reminder_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(FirebaseAuth.instance.currentUser.uid);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ReminderListPage();
          }
          print('test3');
          return LoginPage();
        },
      ),
      // home: ChangeNotifierProvider<SignUpModel>(
      //   create: (_) => SignUpModel(),
      //   child: Scaffold(
      //     appBar: AppBar(
      //       title: Text('リマインダー'),
      //     ),
      //     body: Consumer<SignUpModel>(
      //       builder: (context, model, child) {
      //         return Center(
      //           child: Column(
      //             children: [
      //               RaisedButton(
      //                 child: Text('リマインド一覧へ'),
      //                 onPressed: () {
      //                   // ここでなにか
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ReminderListPage()),
      //                   );
      //                 },
      //               ),
      //               RaisedButton(
      //                 child: Text('新規登録'),
      //                 onPressed: () {
      //                   // ここでなにか
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) => SignUpPage()),
      //                   );
      //                 },
      //               ),
      //               RaisedButton(
      //                 child: Text('ログイン'),
      //                 onPressed: () {
      //                   // ここでなにか
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) => LoginPage()),
      //                   );
      //                 },
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

// class _LoginCheck extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // ログイン状態に応じて、画面を切り替える
//     final bool _loggedIn = context.watch<AuthModel>().loggedIn;
//     return _loggedIn
//         ? MyHomePage(
//             title: 'カウンター',
//           )
//         : LoginForm();
//   }
// }
