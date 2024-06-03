import 'dart:convert';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';

import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/otpVerify/manager/otpManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:http/http.dart';

class otpServiceApi {
  var apiService = HttpService();
  var error = ErrorOtp();
  OtpManager dataManager;
  otpServiceApi({required this.dataManager});
  otpServiceApiManager(
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

    var userId = await LocalStore().getUserID();
    try {
      var url = ConstantUrls.wsOtpVerifyPhoneNumber;

      var param = {
        "otp": dataManager?.otpCodeTF,
        "user_id": userId,
      };
      print("params- ${param}");
      error.otp = "";
      error.user_id = "";
      error.message = "";
      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url);
      print('phone verified response ${jsonResponse}');
      print("url--$url");
      print("param--$param");
      // dismissWaitDialog();

      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422 ) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            error.message = errors["message"].toString();
            if (error.message != "") {
              showAlert(error.message);
            }
          }
          onError();
        }else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } 
         else if (jsonResponse["status"] == ResponseStatus.httpFlase) {
          var errorMessage = jsonResponse["message"];
          showAlert(errorMessage);
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          await storeInfoinSession(jsonResponse);
          dataManager.oTp=jsonResponse["otp"].toString();
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
    await LocalStore().saveEmail(email);
    await LocalStore().saveUserID(userId);
    await LocalStore().saveName(name);
    await LocalStore().saveRegisteredPhoneNumber(registeredPhoneNumber);
    await LocalStore().saveOTP(otp);
    await LocalStore().savePhoneVerifiedAt(phoneVerifiedAt);
    await LocalStore().saveProfileImage(profileImage);
    await LocalStore().saveToken(token);
  }

  

  //Resend Otp Api
  resendOtpServiceApiManager(
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

    var userId = await LocalStore().getUserID();
    try {
      var url = ConstantUrls.wsResendOtp;

      var param = {
        // "otp": dataManager?.otpCodeTF,
        "user_id": userId,
      };
      print("params- ${param}");
      error.otp = "";
      error.user_id = "";
      error.message = "";
      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url);
      print('phone verified response ${jsonResponse}');
      print("url--$url");
      print("param--$param");
      // dismissWaitDialog();

      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422 ) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            error.message = errors["message"].toString();
            if (error.message != "") {
              showAlert(error.message);
            }
          }
          onError();
        }else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } 
         else if (jsonResponse["status"] == ResponseStatus.httpFlase) {
          var errorMessage = jsonResponse["message"];
          showAlert(errorMessage);
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          await storeOTP(jsonResponse);

           dataManager.oTp=jsonResponse["otp"].toString();
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
  Future<void> storeOTP(jsonResponse) async {
    var otp = jsonResponse["otp"].toString();
    await LocalStore().saveOTP(otp);
  }
}

class ErrorOtp {
  var otp = "";
  var user_id = "";
  var message = "";
}
