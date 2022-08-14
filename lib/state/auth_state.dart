import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:savemymoney/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savemymoney/models/auth.dart';

class AuthState extends ChangeNotifier {
  //초기 로그인 상태 Uninitialized
  AuthLoginState _loginState = AuthLoginState.Uninitialized;

  //외부에서 접근하기 위한 getter 변수
  AuthLoginState get loginState => _loginState;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    //Firebase의 User 상태가 변경됨을 리스너
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = AuthLoginState.Authenticated;
      } else {
        _loginState = AuthLoginState.Unauthenticated;
      }
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      dev.log('signIn Error -> $e');
      errorCallback(e);
    }
  }

  Future<void> signUp(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      dev.log('signUp Error -> $e');
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
