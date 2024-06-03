import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';

class FirebaseService {
  final _firbaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firbaseMessaging.requestPermission();
    final fcmToken = await _firbaseMessaging.getToken();
    print("fcmhereis- ${fcmToken}");
    late Stream<String> _tokenStream;

//  void setToken(String? fcmtoken) async {
    print('FCM Token2: $fcmToken');
    await LocalStore().setFCMToken(fcmToken ?? "");
//  }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
  }

  Future<void> handleBackgroundNotification(RemoteMessage message) async {
    print("notificationBody: ${message.notification?.title}");
  }
}
