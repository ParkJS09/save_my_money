import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg, Function callback) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: '확인',
        onPressed: () {
          callback;
        },
      ),
    ),
  );
}
