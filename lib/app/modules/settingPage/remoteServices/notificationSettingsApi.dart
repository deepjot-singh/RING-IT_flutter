import 'dart:convert';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/settingPage/manager/notificationSettingsManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class NotificationSettingsApi {
  var api = HttpService();
  NotificationSettingsManager dataManager;
  NotificationSettingsApi({required this.dataManager});

  toggleSelection({onSuccess, onError}) async {
    try {
      print("njnknjn");
      print("url--${dataManager.reqtype}");
      var url = ConstantUrls.wsUpdateNotificationStatus + dataManager.reqtype;
      Map<dynamic, dynamic>? jsonResponse = await api.getService(url: url,isNeedFullScreenLoader: false);
      //  print("url--${url}");
      print("!!$jsonResponse");
      if (jsonResponse != null) {
        // var responseBody = jsonDecode(jsonResponse);
        // responseBody = responseBody[''];
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422 ) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            onError();
          }else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } 
           else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
            onSuccess();
          }
        }
      }
    } catch (e) {
      showAlert(ConstantText.somethingWentWrong);
      ConstantText.somethingWentWrong;
    }
  }

  getToggleStatus({onSuccess, onError}) async {
    try {
    
      print("njnknjn");
      
      var url = ConstantUrls.wsGetNotificationStatus;
      Map<dynamic, dynamic>? jsonResponse = await api.getService(url: url,isNeedFullScreenLoader: false);
      //  print("url--${url}");
      print("!!$jsonResponse");
      if (jsonResponse != null) {
        // var responseBody = jsonDecode(jsonResponse);
        // responseBody = responseBody[''];
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          // var errors = jsonResponse["errors"];
          // var isMessageKeyAvail = errors.containsKey("message");
          // if (isMessageKeyAvail) {
          //   onError();
           }
           else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
            var is_email = jsonResponse['is_email'];
            var is_notification = jsonResponse['is_notification'];
            onSuccess(is_email, is_notification);
         // }
        }
      }
    } catch (e) {
      showAlert(ConstantText.somethingWentWrong);
      ConstantText.somethingWentWrong;
    }
  }
}
