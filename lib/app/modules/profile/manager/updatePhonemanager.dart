import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:foodorder/app/modules/profile/manager/verifyPhoneNumberManager.dart';
import 'package:foodorder/app/modules/profile/remoteService/updatePhoneApi.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class UpdatePhoneManager {
  var OTPVerifiedManager = VerifyPhoneNumberManager();
  TextEditingController phoneTf = TextEditingController();
  TextEditingController countryCodeTf = TextEditingController();
  String code = "+91";
  var isLoading = true;
  var phoneNumberErrorMsg = "";

  validation({
    required onRefresh,
    required context,
    // required onShowOtpSection
  }) {
    print("PhoneTf---${phoneTf}");
    phoneNumberErrorMsg = "";
    bool validationSuccess = true;
    if (phoneTf.text.trim().isEmpty) {
      print("PhoneNumber--${phoneTf.text}");
      phoneNumberErrorMsg = ConstantText.required;
      print('phoneNumberErrorMsg ${phoneNumberErrorMsg}');
      onRefresh();
      validationSuccess = false;
    }
    if (countryCodeTf.text.isEmpty) {
      countryCodeTf.text = code;
    }
    if (phoneTf.text.isNotEmpty && phoneTf.text.length != 10) {
      phoneNumberErrorMsg = ConstantText.phoneNumberMustContain10Digits;
      print("object${phoneNumberErrorMsg}");
      onRefresh();
      validationSuccess = false;
    }
    if (validationSuccess) {
      print("ValidationSuccess");
      onRefresh();
      var msg = "Is this number correct?";
      showAlertWithConfirmButton(
          msg: msg,
          onTap: () {
            _updatePhoneNumber(onRefresh: onRefresh, context: context);
          });
    }
  }

  _updatePhoneNumber({onRefresh, context}) async {
    print("PhoneNumber-- $phoneTf");
    await UpdatePhoneNetworkManager(updateManager: this).updatePhoneNumber(
        // context:context,
        phoneTf: phoneTf.text,
        countryCode: countryCodeTf.text,
        onSuccess: () async {
          onRefresh();
        },
        onError: () {
          isLoading = false;
        });
  }
}
