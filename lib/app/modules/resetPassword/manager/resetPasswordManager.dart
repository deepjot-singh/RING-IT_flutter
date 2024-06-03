import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/resetPassword/remoteService/resetPasswordApi.dart';

class ResetPasswordManager {
  TextEditingController newPassTF = TextEditingController();
  TextEditingController newPassConfTF = TextEditingController();

  var errorMsgNewPass = "";
  var errorMsgNewPassConf = "";

  var obscureTextNew = true;
  var obscureTextNewConf = true;

  validResetPasswordForm({required onRefresh}) {
    errorMsgNewPass = "";
    errorMsgNewPassConf = "";
    bool resetPasswordSuccess = true;

    if (newPassTF.text.trim().isEmpty) {
      errorMsgNewPass = ConstantText.Required;
      onRefresh();
      resetPasswordSuccess = false;
    }
    if (newPassConfTF.text.trim().isEmpty) {
      errorMsgNewPassConf = ConstantText.Required;
      onRefresh();
      resetPasswordSuccess = false;
    }
    if (newPassTF.text.trim().isNotEmpty &&
        newPassConfTF.text.trim().isNotEmpty &&
        newPassTF.text != newPassConfTF.text) {
      errorMsgNewPassConf = ConstantText.cnfPswdDoesNotMatch;
      onRefresh();
      resetPasswordSuccess = false;
    }

    //password length must be 6
    if (newPassTF.text.trim().isNotEmpty && newPassTF.text.trim().length < 6) {
      errorMsgNewPass = ConstantText.passwordLength;
      onRefresh();
      resetPasswordSuccess = false;
    }

      //password length must be 6
    if (newPassConfTF.text.trim().isNotEmpty && newPassConfTF.text.trim().length < 6) {
      errorMsgNewPassConf = ConstantText.passwordLength;
      onRefresh();
      resetPasswordSuccess = false;
    }
    print('change_pass_Success $resetPasswordSuccess');
    if (resetPasswordSuccess) {
      print("success");
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _resetPassword(onRefresh);
    }
  }

  _resetPassword(onRefresh) {
    var apiManager = ResetPasswordNetworkManager(resetManager: this);
    apiManager.ResetPasswordApi(
        onError: () {
          errorMsgNewPass = apiManager.error.newPass;
        },
        newPassTF: newPassTF.text,
        onSuccess: () async {
          onRefresh();
        });
  }
}
