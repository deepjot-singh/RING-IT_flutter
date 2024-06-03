import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/remoteServices/loginWithNumberApi.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';

class LoginWithNumberManager {
  TextEditingController phoneTf = TextEditingController();
  TextEditingController countryCodeTF = TextEditingController();
  TextEditingController passwordTF = TextEditingController();
String code = "+91" ;
  var phoneNumberErrorMsg = "";
  var passwordErrorMsg = "";
  var obscureTextNewConf = true;
  var errorMsgNewPassConf = "";

  validation({required onRefresh, required context}) {
    phoneNumberErrorMsg = "";
    passwordErrorMsg = "";

    bool validationSuccess = true;
    if (phoneTf.text.trim().isEmpty) {
      print("phoneTF");
      phoneNumberErrorMsg = ConstantText.required;
      onRefresh();
      validationSuccess = false;
    }
    if (countryCodeTF.text.trim().isEmpty) {
      countryCodeTF.text = code ;
    }
    if (passwordTF.text.trim().isEmpty) {
      print("fwef");
      passwordErrorMsg = ConstantText.required;
      onRefresh();
      validationSuccess = false;
    }
    if (phoneTf.text.trim().isNotEmpty && phoneTf.text.length != 10) {
      phoneNumberErrorMsg = ConstantText.phoneNumberMustContain10Digits;
      print("object${phoneNumberErrorMsg}");
      onRefresh();
      validationSuccess = false;
    }
    //password length must be 6
    if (passwordTF.text.trim().isNotEmpty &&
        passwordTF.text.trim().length < 6) {
      passwordErrorMsg = ConstantText.passwordLength;
      onRefresh();
      validationSuccess = false;
    }
    if (validationSuccess) {
      print("validation success");
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _loginApi(onRefresh: onRefresh, context: context);
    }
  }

  _gotoScreen() async {
    var isPhoneVerifiedAt = await LocalStore().getPhoneVerifiedAt();
    var token = await LocalStore().getToken();

    print('isPhoneVerifiedAt${isPhoneVerifiedAt}');
    if (isPhoneVerifiedAt != 'null' && token != 'null') {
      Routes.gotoMainScreen(GlobalVariable.getRootContext());

      // Routes.pushSimpleAndReplaced(
      //     context: GlobalVariable.getRootContext(), child: HomeScreenView());
    } else {
      Routes.pushSimpleAndReplaced(
          context: GlobalVariable.getRootContext(), child: OTPVerifyView());
    }
  }

  _loginApi({required onRefresh, needLoader = true, context}) {
    var apiManager = LoginWithNumberNetworkManager(dataManager: this);
    apiManager.LoginWithNumberApi(
        needLoader: needLoader,
        context: context,
        onError: () {
          onRefresh();
        },
        onSuccess: () async {
          onRefresh();
          _gotoScreen();
        });
  }
}
