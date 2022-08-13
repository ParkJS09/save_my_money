import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/constants.dart';
import 'dart:developer' as dev;
import 'package:savemymoney/state/auth_state.dart';
import 'package:savemymoney/uitls/extensions/inputExtensions.dart';
import 'package:savemymoney/widget/sign_button.dart';
import 'package:savemymoney/widget/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _id;
  String? _password;
  bool _isObscure = true;

  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: deviceHeight / 4),
            Text(
              'Save My Money',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0),
              child: TextFormField(
                controller: _idController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                  hintText: '이메일을 입력해주세요.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? email) {
                  dev.log('email -> $email');
                  if (email == null || email.isEmpty) {
                    return '이메일을 입력해주세요.';
                  }
                  if (!email.isValidEmail()) {
                    dev.log('is not format eamil');
                    return '이메일을 다시 확인해주시기 바랍니다.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 14.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: TextFormField(
                controller: _pwController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  hintText: '비밀번호를 입력해주세요.',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                obscureText: _isObscure,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? password) {
                  dev.log('password -> $_password');
                  if (password == null || password.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  }
                  if (password.length < 6 || password.length < 14) {
                    return '비밀번호는 6~14자 사이입니다.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                SignButton(
                  isSignUp: false,
                  callback: () {
                    if (_idController.text.isEmpty ||
                        _pwController.text.isEmpty) {
                      return showSnackBar(
                          context,
                          '이메일 / 비밀번호를 입력해주시기 바랍니다.${Emojis.pleadingFace}',
                          () {});
                    }
                    context
                        .read<AuthState>()
                        .signIn(_idController.text, _pwController.text, (e) {
                      dev.log('error code : ${e.code}');
                      switch (e.code) {
                        case 'wrong-password':
                          return showSnackBar(context,
                              '비밀번호가 틀렸습니다.${Emojis.pleadingFace}', () {});
                        case 'user-not-found':
                        case 'invalid-email':
                          return showSnackBar(context,
                              '해당 계정이 없습니다.${Emojis.pleadingFace}', () {});
                        case 'too-many-requests':
                          return showSnackBar(
                              context,
                              '잠시 기다리신 후 로그인 해주세요 ${Emojis.pleadingFace}',
                              () {});
                      }
                    });
                  },
                ),
                SignButton(
                  isSignUp: true,
                  callback: () {
                    if (_idController.text.isEmpty ||
                        _pwController.text.isEmpty) {
                      return showSnackBar(
                          context,
                          '이메일 / 비밀번호를 입력해주시기 바랍니다.${Emojis.pleadingFace}',
                          () {});
                    }
                    context
                        .read<AuthState>()
                        .signUp(_idController.text, _pwController.text, (e) {
                      dev.log('error code : ${e.code}');
                      switch (e.code) {
                        case 'wrong-password':
                          return showSnackBar(context,
                              '비밀번호가 틀렸습니다.${Emojis.pleadingFace}', () {});
                        case 'user-not-found':
                        case 'invalid-email':
                          return showSnackBar(context,
                              '해당 계정이 없습니다.${Emojis.pleadingFace}', () {});
                        case 'too-many-requests':
                          return showSnackBar(
                              context,
                              '잠시 기다리신 후 로그인 해주세요 ${Emojis.pleadingFace}',
                              () {});
                        default:
                          return showSnackBar(context,
                              '${e.message} ${Emojis.pleadingFace}', () {});
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
