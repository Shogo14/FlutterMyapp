import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/book_list_page.dart';
import 'package:myapp/main_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('コリアンダー'),
          ),
          body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Text(
                    model.kboyText,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  RaisedButton(
                    child: Text('ボタン'),
                    onPressed: () {
                      // ここでなにか
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookList()),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}