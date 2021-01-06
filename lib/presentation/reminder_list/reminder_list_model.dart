import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/domain/reminder.dart';

class ReminderListModel extends ChangeNotifier {
  List<Reminder> reminders = [];
  final currentUserUid = FirebaseAuth.instance.currentUser.uid;

  Future fetchReminders() async {
    final reminderRef = await FirebaseFirestore.instance
        .collection('reminders')
        .where("uid", isEqualTo: currentUserUid)
        .get();
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
