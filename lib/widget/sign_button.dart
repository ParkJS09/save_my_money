import 'package:flutter/material.dart';
import 'package:savemymoney/constants.dart';

class SignButton extends StatelessWidget {
  const SignButton({
    Key? key,
    required isSignUp,
    required callback,
  })  : _isSignUp = isSignUp,
        _callback = callback,
        super(key: key);

  final bool _isSignUp;
  final Function _callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _callback();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              // Change your radius here
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              _isSignUp ? kSecondary : kPrimaryColor),
        ),
        child: Text(_isSignUp ? '회원가입' : '로그인'),
      ),
    );
  }
}
