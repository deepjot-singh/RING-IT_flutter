import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/otpVerify/remoteService/otpVerifyServiceApi.dart';
import 'package:foodorder/app/modules/resetPassword/view/resetPasswordView.dart';

class OtpManager {
  String oTp="";
  var otpCodeTF = "";
  var otpErrorMsg = "";
  validation({required onRefresh, isForgotPassword = false}) {
    otpErrorMsg = "";
    bool validationSuccess = true;
    if (otpCodeTF.toString().isEmpty) {
      otpErrorMsg = ConstantText.required;
      validationSuccess = false;
      onRefresh();
      return;
    }
    if (otpCodeTF.toString().length < 4) {
      otpErrorMsg = "Must 4 digits"; //ConstantText.required;
      validationSuccess = false;
      onRefresh();
      return;
    }
    print('validationSuccess $validationSuccess');
    if (validationSuccess) {
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _otpApi(onRefresh: onRefresh, isForgotPassword: isForgotPassword);
    }
  }

  _otpApi({onRefresh, context, needLoader = true, isForgotPassword = false}) {
    var apiManger = otpServiceApi(dataManager: this);
    apiManger.otpServiceApiManager(
        context: context,
        needLoader: needLoader,
        onError: () {
          onRefresh();
        },
        onSuccess: () {
          //if forgot password if true then redirect to reset password form
          if (isForgotPassword) {
            Routes.pushSimpleAndReplaced(
                context: GlobalVariable.getRootContext(),
                child: ResetPasswordView());
          } else {
            Routes.pushSimpleAndReplaced(
                context: GlobalVariable.getRootContext(),
                child: HomeScreenView());
          }
        });
  }

  resendOtpValidation({required onRefresh, isForgotPassword = false}) {
    otpErrorMsg = "";
    bool validationSuccess = true;
    if (otpCodeTF.toString().isEmpty) {
      otpErrorMsg = ConstantText.required;
      validationSuccess = false;
      onRefresh();
      return;
    }
    if (otpCodeTF.toString().length < 4) {
      otpErrorMsg = "Must 4 digits"; //ConstantText.required;
      validationSuccess = false;
      onRefresh();
      return;
    }
    print('validationSuccess $validationSuccess');
    if (validationSuccess) {
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      resendOtpApi(onRefresh: onRefresh, isForgotPassword: isForgotPassword);
    }
  }

  resendOtpApi(
      {onRefresh, context, needLoader = true, isForgotPassword = false}) {
    var apiManger = otpServiceApi(dataManager: this);
    apiManger.resendOtpServiceApiManager(
        context: context,
        needLoader: needLoader,
        onError: () {
        },
        onSuccess: () {
          onRefresh();
          // //if forgot password if true then redirect to reset password form
          // if (isForgotPassword) {
          //   Routes.pushSimpleAndReplaced(
          //       context: GlobalVariable.getRootContext(),
          //       child: ResetPasswordView());
          // } else {
          //   Routes.pushSimpleAndReplaced(
          //       context: GlobalVariable.getRootContext(),
          //       child: HomeScreenView());
          // }
        });
  }
}
