import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/constants.dart';
import 'package:savemymoney/providers/expense_provider.dart';
import 'package:savemymoney/state/auth_state.dart';
import 'package:savemymoney/state/my_info_state.dart';
import 'package:savemymoney/theme.dart';
import 'screens/home/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthState>(
          create: (context) => AuthState(),
        ),
        ChangeNotifierProvider<MyInfoState>(
          create: (context) => MyInfoState(),
        ),
        ChangeNotifierProvider<ExpenseProvider>(
          create: (context) => ExpenseProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: HomePage(),
    );
  }
}
