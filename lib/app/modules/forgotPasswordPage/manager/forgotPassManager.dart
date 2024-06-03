import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/forgotPasswordPage/remoteService/forgotPassApi.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';

class ForgotPasswordManager {
  TextEditingController phoneNumberTF = TextEditingController();
  TextEditingController countryCodeTF = TextEditingController();
  String code = "+91";
  var phoneNumberErrorMsg = "";
  validation({required onRefresh, required context}) {
    phoneNumberErrorMsg = "";
    bool validationSuccess = true;
    if (phoneNumberTF.text.trim().isEmpty) {
      phoneNumberErrorMsg = ConstantText.required;
      print("object${phoneNumberErrorMsg}");
      onRefresh();
      validationSuccess = false;
    }
     if (countryCodeTF.text.trim().isEmpty) {
     countryCodeTF.text = code ;
    }
    if (phoneNumberTF.text.isNotEmpty && phoneNumberTF.text.length != 10) {
      phoneNumberErrorMsg = ConstantText.phoneNumberMustContain10Digits;
      print("object--${phoneNumberErrorMsg}");
      onRefresh();
      validationSuccess = false;
    }
    if (validationSuccess) {
      var userPhoneNumber = phoneNumberTF.text;
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _forgotPassApi(onRefresh: onRefresh, userPhoneNumber: userPhoneNumber);
    }
  }

  _forgotPassApi({onRefresh, userPhoneNumber, needLoader = true}) {
    var apiManger = ForgotPasswordNetworkManager(dataManager: this);
    apiManger.ForgotPassApi(
        needLoader: needLoader,
        onError: () {
          onRefresh();
        },
        onSuccess: () {
          Routes.pushSimpleAndReplaced(
              context: GlobalVariable.getRootContext(),
              child: OTPVerifyView(
                userPhoneNumber: userPhoneNumber,
                country_code: countryCodeTF.text,
                isForgotPassword: true,
              ));
        });
  }
}
