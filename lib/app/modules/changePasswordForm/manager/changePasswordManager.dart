import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/changePasswordForm/remoteServices/changePasswordApi.dart';

class ChangeManager {
  TextEditingController oldPassTF = TextEditingController();
  TextEditingController newPassTF = TextEditingController();
  TextEditingController newPassConfTF = TextEditingController();

  var errorMsgOldPass = "";
  var errorMsgNewPass = "";
  var errorMsgNewPassConf = "";
  var obscureText = true;
  var obscureTextNew = true;
  var obscureTextNewConf = true;

  validChangePassForm({required onRefresh}) {
    errorMsgOldPass = "";
    errorMsgNewPass = "";
    errorMsgNewPassConf = "";
    bool changePassSuccess = true;

    if (oldPassTF.text.trim().isEmpty) {
      errorMsgOldPass = ConstantText.required;
      onRefresh();
      changePassSuccess = false;
    }
    if (newPassTF.text.trim().isEmpty) {
      errorMsgNewPass = ConstantText.required;
      onRefresh();
      changePassSuccess = false;
    }
    if (newPassConfTF.text.trim().isEmpty) {
      errorMsgNewPassConf = ConstantText.required;
      onRefresh();
      changePassSuccess = false;
    }
    //password length must be 6
    if (oldPassTF.text.trim().isNotEmpty && oldPassTF.text.trim().length < 6) {
      errorMsgOldPass = ConstantText.passwordLength;
      onRefresh();
      changePassSuccess = false;
    }
    if (newPassTF.text.trim().isNotEmpty && newPassTF.text.trim().length < 6) {
      errorMsgNewPass = ConstantText.passwordLength;
      onRefresh();
      changePassSuccess = false;
    }
    if (newPassConfTF.text.trim().isNotEmpty &&
        newPassConfTF.text.trim().length < 6) {
      errorMsgNewPassConf = ConstantText.passwordLength;
      onRefresh();
      changePassSuccess = false;
    }
    if (newPassTF.text.trim().isNotEmpty &&
        newPassConfTF.text.trim().isNotEmpty &&
        newPassTF.text != newPassConfTF.text) {
      errorMsgNewPassConf = ConstantText.cnfPswdDoesNotMatch;
      onRefresh();
      changePassSuccess = false;
    }
    if (oldPassTF.text.trim().isNotEmpty &&
        newPassTF.text.trim().isNotEmpty &&
        oldPassTF.text == newPassTF.text) {
      errorMsgNewPass = ConstantText.newPassShouldNotMatchWithOldPass;
      onRefresh();
      changePassSuccess = false;
    }

    print('change_pass_Success $changePassSuccess');
    if (changePassSuccess) {
      print("success");
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _changePass(onRefresh);
    }
  }

  _changePass(onRefresh) {
    var apiManager = ChangePasswordManager(dataManager: this);
    apiManager.ChangePass(
        onError: () {
          errorMsgOldPass = apiManager.error.oldPass;
          errorMsgNewPass = apiManager.error.newPass;
        },
        oldPassTF: oldPassTF.text,
        newPassTF: newPassTF.text,
        newPassConfTF: newPassConfTF.text,
        onSuccess: () async {
          onRefresh();
        });
  }
}
