import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/profile/manager/verifyPhoneNumberManager.dart';

class VerifyPhoneNumberApi {
  var api = HttpService();
  VerifyPhoneNumberManager verifyPhoneManager;
  VerifyPhoneNumberApi({required this.verifyPhoneManager});

  verifyPhoneNumber({onSuccess, onError, otp}) async {
    var url = ConstantUrls.wsOtpVerifyPhoneNumber;
    var param = {"user_id": "1", "otp": otp};
    print("Url-$url");
    print("param--$param");
  }
}
