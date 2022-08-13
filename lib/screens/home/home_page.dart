import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/models/auth.dart';
import 'package:savemymoney/screens/landing_page.dart';
import 'package:savemymoney/screens/login_page.dart';
import 'package:savemymoney/screens/main_page.dart';
import 'package:savemymoney/state/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthState _state = context.watch<AuthState>();
    switch(_state.loginState){
      case AuthLoginState.Uninitialized:
        return LandingPage();
      case AuthLoginState.Unauthenticated:
      case AuthLoginState.Authenticating:
        return LoginPage();
      case AuthLoginState.Authenticated:
        return MainPage();
    };
  }
}
