import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savemymoney/data/mock_data.dart';

class MyInfoState extends ChangeNotifier {
  void getUserInfo() {}

  void addDate(String date, String title, String price) {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    //기존 데이터가 있다면 추가
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {'title': title, 'price': price, 'date': date},
      SetOptions(
        merge: true,
      ),
    );
  }
}
