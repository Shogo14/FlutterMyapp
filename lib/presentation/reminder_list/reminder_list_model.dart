import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/domain/reminder.dart';

class ReminderListModel extends ChangeNotifier {
  List<Reminder> reminders = [];

  Future fetchReminders() async {
    final reminderRef =
        await FirebaseFirestore.instance.collection('reminders').get();
    final reminders = reminderRef.docs.map((doc) => Reminder(doc)).toList();
    this.reminders = reminders;
    notifyListeners();
  }

  Future deleteReminder(Reminder reminder) async {
    await FirebaseFirestore.instance
        .collection('reminders')
        .doc(reminder.documentID)
        .delete();
  }
}
