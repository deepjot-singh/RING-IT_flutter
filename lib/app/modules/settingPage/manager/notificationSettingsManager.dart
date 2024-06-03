import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/settingPage/remoteServices/notificationSettingsApi.dart';

class NotificationSettingsManager {
  var notificationToggleSelected;
  var emailToggleSelected;
  String reqtype = "";
  String? notification;
  String? email;

  updateNotification({required type}) async {
    print("njnknjn");
    reqtype = type;
    await NotificationSettingsApi(dataManager: this).toggleSelection(
        onSuccess: () async {
      print("type--${type}");
      // await LocalStore().saveNotifcationSelection;
      print("Typeee: $type");
    });
  }

  NotificationStatus({onSuccess}) async {
    print("njnknjn111");


    await NotificationSettingsApi(dataManager: this).getToggleStatus(
        onSuccess: (is_email, is_notification) {
      email = is_email;
      
    print('data11a-${email}');
      notification = is_notification;
    });
  }
}
