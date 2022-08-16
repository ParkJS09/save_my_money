import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  DateTime toFormat1() {
    String format = 'yyyy-MM-dd';
    return DateFormat(format).parse(this);
  }
}


extension FormatExtension on DateTime? {
  String toFormat1(){
    String format = 'yyyy-MM-dd';
    if(this == null){
      return DateFormat(format).format(DateTime.now());
    }
    return DateFormat(format).format(this!);
  }

  String toFormat2(){
    String format = 'yyyy년 MM월 dd일';
    if(this == null){
      return DateFormat(format).format(DateTime.now());
    }
    return DateFormat(format).format(this!);
  }

  String toFormat3(){
    String format = 'yyyy-MM';
    if(this == null){
      return DateFormat(format).format(DateTime.now());
    }
    return DateFormat(format).format(this!);
  }
}