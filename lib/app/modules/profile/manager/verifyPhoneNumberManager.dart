import 'package:foodorder/app/modules/profile/remoteService/verifyPhoneNumberApi.dart';

class VerifyPhoneNumberManager {
  var isLoading = true;
  verifyPhoneNumber({onRefresh, otp}) async {
    await VerifyPhoneNumberApi(verifyPhoneManager: this).verifyPhoneNumber(
      otp: otp,
      onSuccess: () {
        onRefresh();
      },
    );

    print("OTP---$otp");
    // await VerifyPhoneNumberApi().verifyPhoneNumber;
  }
}
