import 'dart:math';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/orderHistoryPage/manager/orderHistoryListManager.dart';
import 'package:foodorder/app/modules/orderHistoryPage/model/orderHistoryListModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class orderHistoryApi {
  var api = HttpService();
  OrderHistoryListManager orderHistoryManager;
  orderHistoryApi({required this.orderHistoryManager});

  orderHistoryData({onSuccess, onError}) async {
    // try{
    var finalUrl = ConstantUrls.wsOrderHistory;
    Map<dynamic, dynamic>? jsonResponse =
        await api.getService(url: finalUrl, isNeedFullScreenLoader: false);
    print("OrderHistoryData--$jsonResponse['data']['order_details']");
    if (jsonResponse != null) {
      if (jsonResponse["status+code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422) {
        var msg = jsonResponse["message"].toString();
        showAlert(msg);
        onError();
      } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
        showAlert(ConstantText.somethingWentWrong);
      } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
        var data = jsonResponse["data"];
        print("DATA___$data");
        if (data != null) {
          var list = data as List;
          print('print1=== ${data}');
          List<OrderHistoryListModel> orderHistoryListData =
              list.map((e) => OrderHistoryListModel.fromJson(e)).toList();
          print("asdf--");

          orderHistoryManager.orderHistoryList.addAll(orderHistoryListData);
        }
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        onError();
      }
    }
  }

  // }
}
