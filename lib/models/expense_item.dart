class ExpenseItem {
  int _id = 0;
  String title;
  String price;
  String date;

  ExpenseItem({
    required this.title,
    required this.price,
    required this.date,
  });

  void setId(int id) {
    _id = id;
  }

  ExpenseItem.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        title = json['title'],
        price = json['price'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': title,
        'price': price,
        'date': date,
      };
}
