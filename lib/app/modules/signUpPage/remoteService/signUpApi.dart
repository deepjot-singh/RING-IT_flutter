import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:foodorder/app/modules/signUpPage/manager/signUpManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class SignUpNetworkManagerApi {
  var api = HttpService();
  var error = ErrorSignup();
  SignUpManager dataManager;
  SignUpNetworkManagerApi({required this.dataManager});

  SignUpApi(
      {required onError,
      required onSuccess,
      required needLoader,
      required context}) async {
    var internetCheckMsg = ConstantText.internetCheck;
    if (await internetCheck() == false) {
      showAlert(internetCheckMsg);
      return null;
    }
    var url = ConstantUrls.wsRegister;
    try {
      var param = {
        "country_code": dataManager.countryCodeTf.text,
        "password_confirmation": dataManager.newPassTF.text,
        "role": "user",
        "name": dataManager.nameTf.text,
        "phone_no": dataManager.phoneTf.text,
        "password": dataManager.newPassTF.text
      };
      print("Params--$param");

      Map<dynamic, dynamic>? jsonResponse =
          await api.postService(params: param, url: url);
      print("signup response $jsonResponse");
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422 ||
            jsonResponse["status"] == ResponseStatus.httpFlase) {
          var error = jsonResponse["message"];
          showAlert(error);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          if (jsonResponse["status_code"] == ResponseStatus.http403 ||
              jsonResponse['details']['phone_verified_at'] == null) {
            await storeInfoinSession(jsonResponse);
            Routes.pushSimpleAndReplaced(
                context: GlobalVariable.getRootContext(),
                child: OTPVerifyView(
                  country_code: dataManager.countryCodeTf.text,
                  userPhoneNumber: dataManager.phoneTf.text,
                ));
          } else {
            var errorMessage = jsonResponse["message"];
            showAlert(errorMessage);
          }
        } else {}
      }
    } catch (e) {
      showAlert(
        ConstantText.error,
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

class ErrorSignup {
  var phone_number = "";
  var country_code = "";
  var name = "";
  var message = "";
}
