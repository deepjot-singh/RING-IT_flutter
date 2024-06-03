import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/signUpPage/remoteService/signUpApi.dart';

class SignUpManager {
  TextEditingController nameTf = TextEditingController();
  TextEditingController phoneTf = TextEditingController();
  TextEditingController countryCodeTf = TextEditingController();

  TextEditingController newPassTF = TextEditingController();
  String code = "+91";
  var obscureTextNewConf = true;
  var errorMsgNameText = "";
  var phoneNumberErrorMsg = "";
  var errorMsgNewPassConf = "";

  validRegistrationForm({required onRefresh, required context}) {
    errorMsgNameText = "";
    errorMsgNewPassConf = "";
    phoneNumberErrorMsg = "";

    bool registrationSuccess = true;

    // print("$fullname,$emailTf,$pswd,$cnfpswd");

    if (nameTf.text.trim().isEmpty) {
      errorMsgNameText = ConstantText.required;
      print("nameTf");

      onRefresh();
      registrationSuccess = false;
    }

    if (phoneTf.text.isEmpty) {
      print("phoneTf");

      phoneNumberErrorMsg = ConstantText.required;
      onRefresh();
      registrationSuccess = false;
    }
    if (phoneTf.text.trim().isNotEmpty && phoneTf.text.length != 10) {
      phoneNumberErrorMsg = ConstantText.phoneNumberMustContain10Digits;
      print("object${phoneNumberErrorMsg}");
      onRefresh();
      registrationSuccess = false;
    }

    if (countryCodeTf.text.isEmpty) {
      print("countryCodeTf");

      countryCodeTf.text = code;
    }

    if (newPassTF.text.trim().isEmpty) {
      errorMsgNewPassConf = ConstantText.required;
      onRefresh();
      registrationSuccess = false;
    }
    //password length must be 6
    if (newPassTF.text.trim().isNotEmpty && newPassTF.text.trim().length < 6) {
      errorMsgNewPassConf = ConstantText.passwordLength;
      onRefresh();
      registrationSuccess = false;
    }
    // if (cnfpswd.text.trim().isEmpty) {
    //   errorCNfPswd = constTexts.match;
    //   onRefresh();
    //   registrationSuccess = false;
    // }
    // if (emailTf.text.trim().isNotEmpty &&
    //     !Validator.isValidEmail(emailTf.text.trim())) {
    //   errorMsgEmailText = constTexts.enterValidEmail;
    //   print("email${emailTf.text}");
    //   onRefresh();
    //   registrationSuccess = false;
    // }
    // if (pswd.text.trim().isNotEmpty &&
    //     cnfpswd.text.trim().isNotEmpty &&
    //     pswd.text != cnfpswd.text) {
    //   errorCNfPswd = constTexts.match;

    //   onRefresh();
    //   registrationSuccess = false;
    // }

    ///
    if (registrationSuccess == true) {
      print("Objj");
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _register(onRefresh: onRefresh, context: context);
    }
  }

  _register({onRefresh, needLoader = true, context}) {
    print("object");
    var apiManger = SignUpNetworkManagerApi(dataManager: this);
    apiManger.SignUpApi(
        needLoader: needLoader,
        context: context,
        onError: () {
          onRefresh();
        },
        onSuccess: () {
//////////////////////////////////////////////////////////////
        });
  }
}
