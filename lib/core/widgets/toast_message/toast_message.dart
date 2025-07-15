import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static showSuccessMessage(BuildContext context, String message) {
    _showToast(message, Colors.green);
  }

  static showErrorMessage(BuildContext context, String message) {
    _showToast(message, Colors.red);
  }

  static void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
