import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:foodorder/app/modules/profile/manager/updatePhonemanager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class UpdatePhoneNetworkManager {
  var api = HttpService();
  UpdatePhoneManager updateManager;
  UpdatePhoneNetworkManager({required this.updateManager});

  updatePhoneNumber({
    onSuccess,
    onError,
    phoneTf,
    countryCode
    //  required context
  }) async {
    print("ppppp3");
    var finalUrl = ConstantUrls.wsUpdatePhoneNumber;
    var param = {"country_code": countryCode, "phone_no": phoneTf};

    print("Params--$param");
    print("URL__$finalUrl");
    Map<dynamic, dynamic>? jsonResponse =
        await api.postService(params: param, url: finalUrl);
    print("UpdateApiResposne-- $jsonResponse");
    if (jsonResponse != null) {
      if (jsonResponse['status_code'] == ResponseStatus.http412 ||
          jsonResponse['status_code'] == ResponseStatus.http422) {
        if (jsonResponse['errors'] != null) {
          var errors = jsonResponse['errors'];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            var msg = "error";
            showAlert(
              msg,
            );
          }
          onError();
        } else {
          showAlert(jsonResponse['message']);
          onError();
        }
      } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
        showAlert(ConstantText.somethingWentWrong);
      } else if (jsonResponse['status_code'] == ResponseStatus.http200) {
        var msg = jsonResponse['message'];
        var OTP = jsonResponse['otp'];
        var finalmsg = msg + OTP;

        showAlert(finalmsg, onTap: () async {
          print("ppppp4");
          onSuccess();
          await storeInfoinSession(jsonResponse);
          Routes.pushSimpleAndReplaced(
              context: GlobalVariable.getRootContext(),
              child: OTPVerifyView(
                country_code:countryCode ,
                userPhoneNumber: phoneTf,
                showTermText: false,
              ));
        });
      }
    }
  }

  Future<void> storeInfoinSession(jsonResponse) async {
    var userId = jsonResponse["user_id"].toString();
    var otp = jsonResponse["otp"].toString();

    await LocalStore().saveUserID(userId);
    await LocalStore().saveOTP(otp);
    await LocalStore().removeToken();
  }
}
