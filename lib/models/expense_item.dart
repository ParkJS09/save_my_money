import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  String title;
  List<ExpenseItem> list = [];
  bool isExpanded = false;

  Expense({
    required this.title
  });
}



class ExpenseItem {
  String title;
  String price;
  DateTime date;
  bool isExpended = false;

  ExpenseItem({
    required this.title,
    required this.price,
    required this.date,
  });

  ExpenseItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        price = json['price'],
        date = json['date'].toDate();

  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'date': date,
      };
}
