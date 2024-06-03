import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/changePasswordForm/manager/changePasswordManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/settingPage/view/settingView.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:http/http.dart';

class ChangePasswordManager {
  var api = HttpService();
  var error = ErrorChangePass();
  ChangeManager dataManager;

  ChangePasswordManager({required this.dataManager});
  ChangePass(
      {required onError,
      required onSuccess,
      required newPassTF,
      required oldPassTF,
      required newPassConfTF}) async {
    try {
      var user_id = await LocalStore().getUserID();

      var url = ConstantUrls.wsChangePass;
      var param = {
        "old_password": oldPassTF,
        "password": newPassTF,
        "password_confirmation": newPassConfTF
      };
      print('param ${param}');
      error.oldPass = "";
      error.newPass = "";
      error.newPassConf = "";

      print("param-${param}");

      Map<dynamic, dynamic>? jsonResponse =
          await api.postService(params: param, url: url);
      print("bjhbcre${jsonResponse}");
      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          if (jsonResponse["message"]) {
            var errors = jsonResponse["message"];
            var isMessageKeyAvail = errors.containsKey("message");
            if (isMessageKeyAvail) {
              error.message = errors["message"].toString();
              if (error.message != "") {
                showAlert((error.message, style: TextStyle(fontSize: 14)));
              }
            }
            onError();
          } else {
            showAlert((jsonResponse["message"]));
          }
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert((ConstantText.somethingWentWrong));
        } else if (jsonResponse["status"] == ResponseStatus.httpFlase) {
          var errorMessage = jsonResponse["message"];
          showAlert((errorMessage));
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          onSuccess();
          showAlert(jsonResponse["message"], DoublePopNeeded: true);
        }
      } else {}
    } catch (e) {
      showAlert(ConstantText.somethingWentWrong);
      print(e);
    }
  }
}

class ErrorChangePass {
  var oldPass = "";
  var newPass = "";
  var newPassConf = "";
  var message = "";
}
