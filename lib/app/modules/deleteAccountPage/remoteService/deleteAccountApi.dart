import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/deleteAccountPage/manager/deleteAccountManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class DeleteAccountNetworkManager {
  var api = HttpService();

  DeleteAccountManager dataManager;
  DeleteAccountNetworkManager({
    required this.dataManager,
  });

  deleteAccount({onSuccess, onError}) async {
    Map<dynamic, dynamic>? jsonResponse =
        await api.getService(url: ConstantUrls.wsDeleteAccount);
    if (jsonResponse != null) {
      if (jsonResponse["status"] == ResponseStatus.http412 ||
          jsonResponse["status"] == ResponseStatus.http422) {
        var errors = jsonResponse["errors"];
        var isMessageKeyAvail = errors.containsKey("message");
        if (isMessageKeyAvail) {}
        onError();
      } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
        onSuccess();
      }
    }
  }

  logOutAccount({onSuccess, onError}) async {
    Map<dynamic, dynamic>? jsonResponse =
        await api.getService(url: ConstantUrls.wsLogOut);
    if (jsonResponse != null) {
      if (jsonResponse["status"] == ResponseStatus.http412 ||
          jsonResponse["status"] == ResponseStatus.http422) {
        var errors = jsonResponse["errors"];
        var isMessageKeyAvail = errors.containsKey("message");
        if (isMessageKeyAvail) {}
        onError();
      }else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } 
       else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
        onSuccess();
      }
    }
  }
}
