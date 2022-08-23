import 'package:flutter/material.dart';
import 'package:savemymoney/models/expense_item.dart';
import 'package:savemymoney/services/firestore_service.dart';
import 'package:savemymoney/uitls/log/log_utils.dart';

class ExpenseProvider with ChangeNotifier {
    final service = FireStoreServices();
    List<Expense> _expenseList = [];
    List<Expense> get expenseList => _expenseList;

    void getDate() async {
      _expenseList = await service.getData();
      log('test', '${_expenseList.length}');
      notifyListeners();
    }

    void addData(String date, String title, String price) {
      service.addDate(date, title, price);
    }
}