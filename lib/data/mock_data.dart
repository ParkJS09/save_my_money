class TestData {
  String title;
  List<TestItem> list;
  bool isExpanded = false;

  TestData({
    required this.title,
    required this.list
  });
}

class TestItem {
  String title;
  int price;
  String date;

  TestItem({
    required this.title,
    required this.price,
    required this.date
  });
}


List<TestData> getTestData() {
  return [
    TestData(
        title: '2022-08-10',
        list: <TestItem>[
          TestItem(
            title: 'TEST_1',
            price: 10000,
            date: '2022-08-10 13:00:01'
          )
        ]
    ),
    TestData(
        title: '2022-08-11',
        list: <TestItem>[
          TestItem(
            title: 'TEST_1',
            price: 10000,
            date: '2022-08-11 13:00:01'
          ),
          TestItem(
            title: 'TEST_2',
            price: 5000,
            date: '2022-08-11 13:00:01'
          )
        ]
    ),
    TestData(
        title: '2022-08-12',
        list: <TestItem>[
          TestItem(
            title: 'TEST_1',
            price: 10000,
            date: '2022-08-12 12:00:11'
          ),
          TestItem(
            title: 'TEST_2',
            price: 5000,
              date: '2022-08-12 13:00:11'
          ),
          TestItem(
            title: 'TEST_2',
            price: 15000,
            date: '2022-08-12 13:01:11'
          )
        ]
    ),
  ];
}