import 'package:flutter/material.dart';
import 'package:myapp/domain/reminder.dart';
import 'package:myapp/presentation/add_reminder/add_reminder_page.dart';
import 'package:provider/provider.dart';

import 'reminder_list_model.dart';

class ReminderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReminderListModel>(
      create: (_) => ReminderListModel()..fetchReminders(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('リマインダー一覧'),
        ),
        body: Consumer<ReminderListModel>(
          builder: (context, model, child) {
            final reminders = model.reminders;
            final listTiles = reminders
                .map(
                  (reminder) => ListTile(
                    leading: Image.network(reminder.imageURL),
                    title: Text(reminder.title),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddReminderPage(
                              reminder: reminder,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchReminders();
                      },
                    ),
                    onLongPress: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('${reminder.title}を削除しますか？'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  // TODO: delete
                                  await deleteReminder(
                                      context, model, reminder);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<ReminderListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddReminderPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchReminders();
              },
            );
          },
        ),
      ),
    );
  }

  Future deleteReminder(
      BuildContext context, ReminderListModel model, Reminder reminder) async {
    try {
      await model.deleteReminder(reminder);

      // await _showDialog(context, '削除しました');
      await model.fetchReminders();
    } catch (e) {
      // await _showDialog(context, e.toString());
      print(e.toString());
    }
  }

  // ignore: missing_return
  Future _showDialog(BuildContext context, title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
