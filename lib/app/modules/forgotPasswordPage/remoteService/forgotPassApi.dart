import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'dart:convert';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';

import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/forgotPasswordPage/manager/forgotPassManager.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';

import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:http/http.dart';

class ForgotPasswordNetworkManager {
  var apiService = HttpService();
  var error = ErrorProfile();
  ForgotPasswordManager? dataManager;
  ForgotPasswordNetworkManager({required this.dataManager});
  ForgotPassApi(
      {required onError,
      required onSuccess,
      required needLoader,
      context}) async {
    var internetCheckMsg = ConstantText.internetCheck;
    if (await internetCheck() == false) {
      showAlert(
        internetCheckMsg,
      );
      return null;
    }
    try {
      var url = ConstantUrls.wsForgotPass;
      print("url--${url}");
      var param = {
        "country_code":  dataManager?.countryCodeTF.text,
        "phone_no": dataManager?.phoneNumberTF.text
      };
      print("params-${param}");
      error.country_code = "";
      error.phone_no = "";
      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url);
      print("login Resopense ${jsonResponse}");

      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422 ||
            jsonResponse["status_code"] == ResponseStatus.http500) {
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
          onSuccess();
        }
      } else {}
    } catch (e) {
      showAlert(
        ConstantText.somethingWentWrong,
      );
      print(e);
    }
  }

  Future<void> storeInfoinSession(jsonResponse) async {
    var userId = jsonResponse["user_id"].toString();
    var otp = jsonResponse["otp"].toString();
    print('userid ${userId}');
    await LocalStore().saveUserID(userId);
    await LocalStore().saveOTP(otp);
  }
}

class ErrorProfile {
  var phone_no = "";
  var country_code = "";
  var message = "";
}
