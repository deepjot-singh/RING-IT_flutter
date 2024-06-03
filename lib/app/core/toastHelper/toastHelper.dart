import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';

class ToastHelper {
  static dismissAll() {
    if (GlobalVariable.scaffoldMessengerState != null) {
      GlobalVariable.scaffoldMessengerState?.removeCurrentSnackBar();
    }
  }

  static showToast({
    msg = "",
  }) {
    final scaffold = ScaffoldMessenger.of(GlobalVariable.getRootContext());
    GlobalVariable.scaffoldMessengerState = scaffold;
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
