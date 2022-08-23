import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:savemymoney/models/expense_item.dart';
import 'package:savemymoney/uitls/extensions/inputExtensions.dart';
import 'package:savemymoney/uitls/log/log_utils.dart';

class FireStoreServices extends ChangeNotifier {
  final String _TAG = 'MyInfoState';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Expense>> getData() async {
    List<Expense> expenseList = [];
    var today = DateTime.now().toFormat3();
    var data = await FirebaseFirestore.instance
        .collection('expense')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(today)
        .orderBy('date', descending: false) //일자별로  정렬
        .get()
        .then((snapshot) {
          log('snapshot.docs', '${snapshot.docs}');
          snapshot.docs.forEach((element) {
            ExpenseItem test = ExpenseItem.fromJson(element.data());
            log('test', 'test ${test.title}');
            Expense expense = Expense(title: test.date.toFormat1());
            expense.list.add(test);
            expenseList.add(expense);
          }
        );
        return expenseList;
    });
    return data;
  }

  Future<void> addDate(String date, String title, String price) async {
    DateTime dateTime = date.toFormat1();
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }

    _db
        .collection('expense')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(dateTime.toFormat3())
        .add({'title': title, 'price': price, 'date': dateTime});
  }
}

class Test {
  String test;
  List<Item> list;

  Test({
    required this.test,
    required this.list,
  });
}

class Item {
  String title;
  String price;
  String date;

  Item({required this.title, required this.price, required this.date});
}
