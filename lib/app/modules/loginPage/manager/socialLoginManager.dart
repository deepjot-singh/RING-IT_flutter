import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/loginPage/remoteService/api.dart';
import 'package:foodorder/app/modules/loginPage/remoteService/appleLoginApi.dart';
import 'package:foodorder/app/modules/loginPage/view/phoneNumberViewforSocialLogin.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginManager {
  TextEditingController phoneNumberTF = TextEditingController();
  String countryCode = "+91";

  var phoneNumberErrorMsg = "";
  static GoogleSignInAccount? googleUser;
  GoogleSignInAuthentication? googleAuth;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: <String>['email', 'profile']);

  googleSignIn(BuildContext context) async {
    try {
      _googleSignIn.signOut();
      googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser?.authentication;
      print("googleUser-$googleUser");
      var token = googleAuth?.accessToken;
      print(googleAuth?.accessToken);
      print(googleUser?.displayName);
      print(googleUser?.email);
      String deviceToken = await LocalStore().getFCMToken();
      print("Device Token-$deviceToken");
      if (token.toString() != "" && token.toString() != "null") {
        googleLoginApi(accessToken: token);
      }
    } catch (error) {
      print(error);
    }
  }

  googleLoginApi({accessToken}) {
    var apiManager = SocialLoginNetworkManager(dataManager: this);
    apiManager.googleLoginApi(
        token: accessToken,
        onError: () {},
        onSuccess: () {
          _googleSignIn.signOut();
          _gotoScreen();
        });
  }

  // appleLogin(BuildContext context) async {
  //   var apiManager = AppleLoginApi(dataManager: this);
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ]);
  //      } catch (error) {
  //     print(error);
  //   }
  // }
  _gotoScreen() async {
    var phoneNo = await LocalStore().getRegisteredPhoneNumber();
    var isPhoneVerifiedAt = await LocalStore().getPhoneVerifiedAt();
    var token = await LocalStore().getToken();

    print('isPhoneVerifiedAt${isPhoneVerifiedAt}');
    print('phoneNo${phoneNo}');
    print('token${token}');

    if (phoneNo == "" || phoneNo == "null") {
      Routes.pushSimple(
          context: GlobalVariable.getRootContext(),
          child: const PhoneNumberLoginViewForSocial());
    } else if (isPhoneVerifiedAt == 'null' && token == 'null') {
      Routes.pushSimpleAndReplaced(
          context: GlobalVariable.getRootContext(),
          child: OTPVerifyView(
            userPhoneNumber: phoneNo,
          ));
    } else {
      Routes.gotoMainScreen(GlobalVariable.getRootContext());
    }
  }

  appleLogin(BuildContext context) async {
    var apiManager = AppleLoginApi(dataManager: this);
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      print("credential-444444$credential");
      // appleLoginApi();
      if (credential.userIdentifier != "" &&
          credential.userIdentifier != "null") {
        apiManager.appleLogin(
            token: credential.userIdentifier,
            name: credential.givenName ?? "No Name",
            onSuccess: () {
              print("Success");
              _gotoScreen();
            });
      }
      print('zxcvbnxcvbnm');
    } catch (error) {
      print(error);
    }
  }

  // appleLoginApi() {
  //   var apiManager = SocialLoginNetworkManager(dataManager: this);
  // }

  validation({required onRefresh}) {
    phoneNumberErrorMsg = "";
    bool validationSuccess = true;
    if (phoneNumberTF.text.trim().isEmpty) {
      phoneNumberErrorMsg = ConstantText.required;
      onRefresh();
      validationSuccess = false;
    }
    if (validationSuccess) {
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _loginApi(onRefresh: onRefresh);
    }
  }

  _loginApi({onRefresh}) {
    var apiManger = SocialLoginNetworkManager(dataManager: this);
    apiManger.loginApi(onError: () {
      onRefresh();
    }, onSuccess: () {
      Routes.pushSimpleAndReplaced(
          context: GlobalVariable.getRootContext(),
          child: OTPVerifyView(userPhoneNumber: phoneNumberTF.text));
    });
  }
}
