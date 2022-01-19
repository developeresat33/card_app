import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void setMessage(String themsg) {
  Fluttertoast.showToast(
    msg: themsg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}

void setMessageValidation(String themsg) {
  Fluttertoast.showToast(
    msg: themsg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
