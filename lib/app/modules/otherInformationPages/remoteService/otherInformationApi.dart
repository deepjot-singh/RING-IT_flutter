import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/otherInformationPages/manager/otherInformationManager.dart';
import 'package:foodorder/app/modules/resetPassword/remoteService/resetPasswordApi.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class OtherInformationApi {
  var api = HttpService();
  OtherInformationManager? dataManager;
  var error = ErrorResetPassword();

  OtherInformationApi({required this.dataManager});

  getContent({required context, required onSuccess, required type}) async {
    print("api route--${type}");

    // try {
    var url = ConstantUrls.wsOtherInformationPage;
    print("api route test--${url}");

    var param = {"type": type};
    print("url--${url}");
    Map<dynamic, dynamic>? jsonResponse =
        await api.postService(params: param, url: url,isNeedFullScreenLoader: false);

    print("param -${jsonResponse}");

    print("url---$url");
    print("param---$param");
    print("Reset Password response-----${jsonResponse} ");

    if (jsonResponse != null) {
      if (jsonResponse["status"] == ResponseStatus.http412 ||
          jsonResponse["status"] == ResponseStatus.http422 ) {
        if (jsonResponse["message"]) {
          var errors = jsonResponse["message"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            error.message = errors["message"].toString();
            if (error.message != "") {
              showAlert(error.message);
            }
          }
          // onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } 
        else {
          showAlert(jsonResponse["message"]);
        }
      } else if (jsonResponse["status"] == ResponseStatus.httpFlase) {
        var errorMessage = jsonResponse["message"];
        showAlert(errorMessage);
      } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
        print("content");
        var data = jsonResponse["data"];
        var content = data["description"].toString();
        print("content22-${content}");
        var title = data["title"].toString();
        print("title33-${title}");


        return onSuccess(content, title);
      }

      // if (jsonResponse!["status"] == true) {
      //   print("content");
      //   var content = jsonResponse["description"].toString();
      //   print("content22-${content}");
      //   var title = jsonResponse["title"].toString();
      //   print("title33-${title}");

      //   // dismissWaitDialog();

      //   return onSuccess(content, title);
      // } else {
      //   showAlert(
      //     ConstantText.somethingWentWrong,
      //   );
      // }
      // } catch (e) {
      //   dismissWaitDialog();
      //   print(e);
      //   showAlert(
      //     ConstantText.somethingWentWrong,
      //   );
      // }
    }
  }
}
