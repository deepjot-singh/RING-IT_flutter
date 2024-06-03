import 'package:foodorder/app/modules/notificationPage/model/notificationListModel.dart';
import 'package:foodorder/app/modules/notificationPage/remoteService/notificationListApi.dart';

class NotificationListManager {
  List<NotificationListModel> notificationList = [];
  var isLoading = true;
  getNotificationList({onRefresh}) async {
    await NotificationListNetworkManager(notificationdataManager: this)
        .notificationData(
      onSuccess: () {
        isLoading = false;
        onRefresh();
        print("---------$notificationList");
        
      },
      onError: () {
        isLoading = false;
      },
    );
  }
}
