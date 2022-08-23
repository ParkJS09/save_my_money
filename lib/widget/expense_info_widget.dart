import 'package:flutter/material.dart';
import 'package:savemymoney/data/mock_data.dart';
import 'package:savemymoney/models/expense_item.dart';

class ExpenseInfoWidget extends StatefulWidget {
  late List<Expense> expenselist = [];

  ExpenseInfoWidget({
    Key? key,
    required this.expenselist,
  }) : super(key: key);

  @override
  State<ExpenseInfoWidget> createState() => _ExpenseInfoWidgetState();
}

class _ExpenseInfoWidgetState extends State<ExpenseInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 600),
      elevation: 1,
      children: widget.expenselist.map((item) {
        return ExpansionPanel(
          isExpanded: item.isExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.title),
            );
          },
          body: DetailTile(item.list),
          canTapOnHeader: true,
        );
      }).toList(),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.expenselist[index].isExpanded = !isExpanded;
        });
      },
    );
  }

  Widget DetailTile(List<ExpenseItem> item) {
    return Column(
      children: item.map((detailItem) {
        return Padding(
          padding: const EdgeInsets.only(
              left: 14.0, top: 8.0, right: 14.0, bottom: 8.0),
          child: ListTile(
            title: Text('${detailItem.date} // ${detailItem.title}'),
            subtitle: Text('${detailItem.price} 원'),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
