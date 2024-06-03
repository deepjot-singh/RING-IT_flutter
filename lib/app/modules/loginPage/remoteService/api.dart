import 'dart:io';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/loginPage/manager/socialLoginManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class SocialLoginNetworkManager {
  SocialLoginManager dataManager;
  var api = HttpService();
  var error = ErrorLogin();
  SocialLoginNetworkManager({required this.dataManager});

  googleLoginApi({required token, required onError, required onSuccess}) async {
    String deviceToken = await LocalStore().getFCMToken();
    var params = {
      "device_type": Platform.isIOS ? "ios" : "android",
      "device_token": deviceToken,
      "access_token": token
    };
    Map<dynamic, dynamic>? jsonResponse =
        await api.postService(params: params, url: ConstantUrls.wsGoogleLogin);
    if (jsonResponse != null) {
      if (jsonResponse["status_code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422) {
        var errors = jsonResponse["errors"];
        var isMessageKeyAvail = errors.containsKey("message");
        if (isMessageKeyAvail) {
          error.message = errors["message"].toString();
          if (error.message != "") {
            showAlert(error.message);
          }
        }
        onError();
      } else if (jsonResponse["status"] == ResponseStatus.httpTrue &&
          jsonResponse["status_code"] == ResponseStatus.http200) {
        await storeInfoinSession(jsonResponse);
        onSuccess();
      } else if (jsonResponse["status_code"] == ResponseStatus.http418) {
        showAlert(
          jsonResponse["message"].toString(),
        );
      } else {
        var isMessageKeyAvail = jsonResponse.containsKey("message");
        if (isMessageKeyAvail) {
          var errorMsg = jsonResponse["message"].toString();
          if (errorMsg != "") {
            showAlert(errorMsg);
          }
        }
      }
    }
  }

  Future<void> storeInfoinSession(jsonResponse) async {
    var userDetail = jsonResponse['details'];
    var userId = userDetail["id"].toString();
    var email = userDetail["email"].toString();
    var name = userDetail["name"].toString();
    var registeredPhoneNumber = userDetail["phone_no"].toString();
    var phoneVerifiedAt = userDetail["phone_verified_at"].toString();
    var profileImage = userDetail["avatar"].toString();
    var token = jsonResponse["access_token"].toString();
    print('token $token');
    print('userid $userId');

    await LocalStore().saveEmail(email);
    await LocalStore().saveUserID(userId);
    await LocalStore().saveName(name);
    await LocalStore().saveRegisteredPhoneNumber(registeredPhoneNumber);
    await LocalStore().savePhoneVerifiedAt(phoneVerifiedAt);
    await LocalStore().saveProfileImage(profileImage);
    await LocalStore().saveToken(token);
  }

  loginApi({required onError, required onSuccess}) async {
    var userId = await LocalStore().getUserID();
    var param = {
      "country_code": dataManager.countryCode,
      "phone_no": dataManager.phoneNumberTF.text,
      "user_id": userId
    };

    Map<dynamic, dynamic>? jsonResponse =
        await api.postService(params: param, url: ConstantUrls.wsAddPhone);
    print("url--${ConstantUrls.wsAddPhone}");
    print("param--$param");
    print('response--${jsonResponse}');

    if (jsonResponse != null) {
      if (jsonResponse["status_code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422) {
        var errorMessage = jsonResponse["message"];
        showAlert(errorMessage);
        onError();
      } else if (jsonResponse["status"] == ResponseStatus.httpTrue &&
          jsonResponse["status_code"] == ResponseStatus.http200) {
        var otp = jsonResponse["otp"].toString();
        await LocalStore().saveOTP(otp);

        onSuccess();
      }
    } else {
      showAlert(ConstantText.somethingWentWrong);
    }
  }
}

class ErrorLogin {
  String message;
  ErrorLogin({this.message = ""});
}
