import 'dart:io';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/view/loginWithNumberView.dart';
import 'package:foodorder/app/modules/resetPassword/manager/resetPasswordManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class ResetPasswordNetworkManager {
  var api = HttpService();
  var error = ErrorResetPassword();
  ResetPasswordManager resetManager;

  ResetPasswordNetworkManager({required this.resetManager});
  ResetPasswordApi(
      {required onError, required onSuccess, required newPassTF}) async {
    try {
      var user_id = await LocalStore().getUserID();
      var url = ConstantUrls.wsResetPassword;
      var param = {"user_id": user_id, "new_password": newPassTF};
      error.newPass = "";
      Map<dynamic, dynamic>? jsonResponse =
          await api.postService(params: param, url: url);
      print("url---$url");
      print("param---$param");
      print("Reset Password response-----${jsonResponse} ");
      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          if (jsonResponse["message"]) {
            var errors = jsonResponse["message"];
            var isMessageKeyAvail = errors.containsKey("message");
            if (isMessageKeyAvail) {
              error.message = errors["message"].toString();
              if (error.message != "") {
                showAlert(error.message);
              }
            }
            onError();
          } else {
            showAlert(jsonResponse["message"]);
          }
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status"] == ResponseStatus.httpFlase) {
          var errorMessage = jsonResponse["message"];
          showAlert(errorMessage);
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          onSuccess();
          showAlert(jsonResponse["message"], onTap: () {
            Routes.pushSimpleAndReplaced(
                context: GlobalVariable.getRootContext(),
                child: PhoneNumberLoginView());
          });
        }
      } else {}
    } catch (e) {
      showAlert(ConstantText.somethingWentWrong);
      print(e);
    }
  }
}

class ErrorResetPassword {
  var newPass = "";
  var message = "";
}
