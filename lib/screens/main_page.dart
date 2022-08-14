import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/state/auth_state.dart';
import 'package:savemymoney/widget/my_character_main.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthState _authProvider = Provider.of<AuthState>(context, listen: false);
    double _height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      appBar: AppBar(
        title: Text('my farm'),
      ),
      body: Column(
        children: [
          Container(
            height: _height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: GameWidget(
              game: MyGame(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _authProvider.signOut();
            },
            child: Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
