import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/state/auth_state.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthState _authProvider = Provider.of<AuthState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('MAIN'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _authProvider.signOut();
          },
          child: Text('LOGOUT'),
        ),
      ),
    );
  }
}
