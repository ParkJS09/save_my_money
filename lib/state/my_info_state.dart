import 'dart:convert';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savemymoney/data/mock_data.dart';
import 'package:savemymoney/models/expense_item.dart';
import 'package:savemymoney/uitls/extensions/inputExtensions.dart';

import '../uitls/log/log_utils.dart';

class MyInfoState extends ChangeNotifier {
  final String _TAG = 'MyInfoState';

  void getUserInfo() {}

  void addDate(String date, String title, String price) async {
    DateTime dateTime = date.toFormat1();
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }
    DocumentReference documentRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('expense')
        .doc(dateTime.toFormat3())
        .collection(dateTime.day.toString())
        .doc();
    documentRef.set({'title': title, 'price': price, 'date': dateTime});
  }
}
