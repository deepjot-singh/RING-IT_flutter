import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/notificationPage/manager/notificationListManager.dart';
import 'package:foodorder/app/modules/notificationPage/model/notificationListModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class NotificationListNetworkManager {
  var api = HttpService();
  NotificationListManager notificationdataManager;
  NotificationListNetworkManager({
    required this.notificationdataManager,
  });

  notificationData({onSuccess, onError}) async {
    try {
      var finalUrl = ConstantUrls.wsNotificationList;
      Map<dynamic, dynamic>? jsonResponse = await api.getService(url: finalUrl);
      print('notificationListData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422 ) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            // showAlert(msg: errors["message"].toString());
          }
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } 
        else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["notifications"];
          if (data != null) {
            var list = data as List;
            List<NotificationListModel> notificationDataList =
                list.map((e) => NotificationListModel.fromJson(e)).toList();
            notificationdataManager.notificationList
                .addAll(notificationDataList);
          }
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              // showAlert(msg: errorMsg);
            }
          }
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      showAlert(
        ConstantText.somethingWentWrong,
      );
    }
  }
}
