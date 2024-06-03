import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class UpdateDeviceToken {
  var apiService = HttpService();
  updateToken({required deviceToken}) async {
    print("jjjjjj");
    var internetCheckMsg = ConstantText.internetCheck;
    //  if (await internetCheck() == false) {
    //   showAlert(internetCheckMsg);
    //   return null;
    // }

    
    var url = ConstantUrls.wsUpdateToken;
    print("param-${url}");
    try {
      var param = {"device_token": deviceToken};

      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url, isNeedFullScreenLoader: false);
      print("param-${param}");
      print('updatetoken-- ${jsonResponse}');
      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          return true ;
        } else if (jsonResponse["status"] == ResponseStatus.http418) {
          showAlertWithConfirmButton(
            msg: jsonResponse["message"].toString(),
            onTap: () {},
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
    } catch (e) {
      print(e);
      showAlert(ConstantText.somethingWentWrong);
    }
  }
}
