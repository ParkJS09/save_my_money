import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/constants.dart';
import 'package:savemymoney/data/mock_data.dart';
import 'package:savemymoney/models/expense_item.dart';
import 'package:savemymoney/providers/expense_provider.dart';
import 'package:savemymoney/screens/expense_register_page.dart';
import 'package:savemymoney/state/auth_state.dart';
import 'package:savemymoney/state/my_info_state.dart';
import 'package:savemymoney/theme.dart';
import 'package:savemymoney/widget/expense_info_widget.dart';
import 'package:savemymoney/widget/my_character_main.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState() {
    final productProvider = Provider.of<ExpenseProvider>(context, listen: false);
    productProvider.getDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Expense> _data = context.watch<ExpenseProvider>().expenseList;
    AuthState _authProvider = Provider.of<AuthState>(context, listen: false);

    double _height = MediaQuery
        .of(context)
        .size
        .height / 3;

    return Scaffold(
      appBar: AppBar(
        title: Text('my farm'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: GameWidget(
              game: MyGame(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14.0,
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  Text(
                    '?????? ??????',
                    style: textTheme().headline1,
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  LinearPercentIndicator(
                    lineHeight: 30.0,
                    percent: 0.8,
                    center: const Text(
                      '?????? ?????? / ?????? ??????',
                      style: TextStyle(color: Colors.white),
                    ),
                    progressColor: kPrimaryColor,
                    backgroundColor: kSecondary,
                    barRadius: const Radius.circular(14.0),
                  ),
                  const SizedBox(
                    height: 14.0,
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  Text(
                    '?????? ??????',
                    style: textTheme().headline1,
                  ),
                  const SizedBox(
                    height: 14.0,
                  ),
                  ExpenseInfoWidget(
                    expenselist: _data,
                  ),
                ],
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     _authProvider.signOut();
          //   },
          //   child: Text('LOGOUT'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExpenseRegisterPage()),
          );
        },
        child: const Icon(
          Icons.add
        ),
      ),
    );
  }
}


