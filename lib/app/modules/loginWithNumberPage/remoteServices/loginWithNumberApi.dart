import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/manager/loginWithNumberManager.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:http/http.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class LoginWithNumberNetworkManager {
  var apiService = HttpService();
  var error = ErrorLogin();
  LoginWithNumberManager? dataManager;
  LoginWithNumberNetworkManager({required this.dataManager});
  LoginWithNumberApi(
      {required onError,
      required onSuccess,
      required needLoader,
      required context}) async {
    var internetCheckMsg = ConstantText.internetCheck;
    if (await internetCheck() == false) {
      showAlert(
        internetCheckMsg,
      );
      return null;
    }

    try {
      String deviceToken = await LocalStore().getFCMToken();
      print("deviceToken- ${deviceToken}");
      var url = ConstantUrls.wsLogin;
      var param = {
        "country_code": dataManager?.countryCodeTF.text,
        "phone_no": dataManager?.phoneTf.text,
        "password": dataManager?.passwordTF.text,
        "device_type": Platform.isIOS ? "ios" : "android",
        "device_token": deviceToken,
        "role": "user"
      };
      print("params- ${param}");
      error.country_code = "";
      error.phone_no = "";
      error.password = "";

      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url);
      print('login response ${jsonResponse}');
      print("url--$url");
      print("param--$param");
      // dismissWaitDialog();

      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            error.message = errors["message"].toString();
            if (error.message != "") {
              showAlert(error.message);
            }
          }
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status"] == ResponseStatus.httpFlase) {
          if (jsonResponse["status_code"] == ResponseStatus.http403) {
            await storeInfoinSession(jsonResponse);

            Routes.pushSimpleAndReplaced(
                context: GlobalVariable.getRootContext(),
                child: OTPVerifyView(
                  country_code: dataManager?.countryCodeTF.text,
                  userPhoneNumber: dataManager?.phoneTf.text,
                ));
          } else {
            var errorMessage = jsonResponse["message"];
            showAlert(errorMessage);
          }
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          await storeInfoinSession(jsonResponse);
          onSuccess();
        }
      } else {
        // showAlert('OOPS! Something went wrong.');
      }
    } catch (e) {
      showAlert(
        ConstantText.msgSomethingWentWrong,
      );
      print(e);
    }
  }

  //store session

  Future<void> storeInfoinSession(jsonResponse) async {
    var userDetail = jsonResponse['details'];
    var userId = userDetail["id"].toString();
    var email = userDetail["email"].toString();
    var name = userDetail["name"].toString();
    var registeredPhoneNumber = userDetail["phone_no"].toString();
    var otp = userDetail["otp"].toString();
    var phoneVerifiedAt = userDetail["phone_verified_at"].toString();
    var profileImage = userDetail["avatar"].toString();
    var token = jsonResponse["access_token"].toString();
    print('token ${token}');
    print('userid ${userId}');

    await LocalStore().saveEmail(email);
    await LocalStore().saveUserID(userId);
    await LocalStore().saveName(name);
    await LocalStore().saveRegisteredPhoneNumber(registeredPhoneNumber);
    await LocalStore().saveOTP(otp);
    await LocalStore().savePhoneVerifiedAt(phoneVerifiedAt);
    await LocalStore().saveProfileImage(profileImage);
    await LocalStore().saveToken(token);
  }
}

class ErrorLogin {
  var country_code = "";
  var phone_no = "";
  var password = "";
  var message = "";
}
