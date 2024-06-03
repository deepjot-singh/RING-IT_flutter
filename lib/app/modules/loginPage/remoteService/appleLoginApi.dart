import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/loginPage/manager/socialLoginManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class AppleLoginApi {
  SocialLoginManager dataManager;
  var api = HttpService();
  var error = ErrorLogin();

  AppleLoginApi({required this.dataManager});
  appleLogin({required token, required name, required onSuccess}) async {
    String apple_id = token;
    var params = {
      "device_type": "ios",
      "device_token": "fhfg",
      "apple_id": apple_id
    };
    Map<dynamic, dynamic>? jsonResponse =
        await api.postService(params: params, url: ConstantUrls.wsAppleLogin);
    if (jsonResponse != null) {
      if (jsonResponse["status_code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422 ||
          jsonResponse["status"] == ResponseStatus.httpFlase) {
        showAlert(
          jsonResponse["message"].toString(),
        );
      } else if (jsonResponse["status"] == ResponseStatus.httpTrue ||
          jsonResponse["status_code"] == ResponseStatus.http200) {
        print('apple response -_${jsonResponse}');
        var data = jsonResponse["details"];
        print("DATA----$data");
        var id = data["id"];
        var otp = data["otp"];
        await storeInfoSession(jsonResponse);

        onSuccess();
      } else {
        showAlert(ConstantText.somethingWentWrong);
      }
    }
    print("AppleId--$apple_id");
  }

  Future<void> storeInfoSession(jsonResponse) async {

    var userId = jsonResponse["details"]["id"].toString();
    var email = jsonResponse["details"]["email"].toString();
    var name = jsonResponse["details"]["name"].toString();
    var registeredPhoneNumber = jsonResponse["details"]["phone_no"].toString();
    var phoneVerifiedAt = jsonResponse["details"]["phone_verified_at"].toString();
    var profileImage = jsonResponse["details"]["avatar"].toString();
    var token = jsonResponse["access_token"].toString();
    var otp = jsonResponse["details"]["otp"].toString();
    print("PHONE--$registeredPhoneNumber");

    await LocalStore().saveOTP(otp);
    await LocalStore().saveEmail(email);
    await LocalStore().saveUserID(userId);
    await LocalStore().saveName(name);
    await LocalStore().saveRegisteredPhoneNumber(registeredPhoneNumber);
    await LocalStore().savePhoneVerifiedAt(phoneVerifiedAt);
    await LocalStore().saveProfileImage(profileImage);
    await LocalStore().saveToken(token);
  }
}

class ErrorLogin {}
