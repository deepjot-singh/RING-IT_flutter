// MANAGES LOCALLY STORED VALUES
import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  final String _IsGetStarted = "_IsGetStarted";
  final String _UserID = "_UserID";
  final String _Token = "_Token";
  final String _NotificationSelection = "_NotificationSelection";
  final String _EmailSelection = "_EmailSelection";
  final String _email = "_email";
  final String _fcmToken = "_fcmToken";
  final String _name = "_name";
  final String _phoneVerifiedAt = "_phoneVerifiedAt";
  final String _profileImage = "_profileImage";
  final String _registeredPhoneNumber = "_registeredPhoneNumber";
  final String _OTP = "_OTP";

  Future<bool> saveIsGetStarted(String value) async {
    print('value $value');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_IsGetStarted, value));
  }

  Future<String> getIsGetStarted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_IsGetStarted) ?? '';
    return value;
  }

  Future<bool> saveUserID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_UserID, value));
  }

  Future<String> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_UserID) ?? '';
    print("UserID$value");
    return value;
  }

  Future<bool> saveToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    return (prefs.setString(_Token, value));
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_Token) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<bool> saveNotifcationSelection(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    return (prefs.setString(_NotificationSelection, value));
  }

  Future<String> getNotificationSelection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_NotificationSelection) ?? '';
    print("Notification Selection $value");
    return value;
  }

  Future<bool> saveEmailSelection(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    return (prefs.setString(_EmailSelection, value));
  }

  Future<String> getEmailSelection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_EmailSelection) ?? '';
    print("Email Selection $value");
    return value;
  }

  Future<bool> saveEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_email, value));
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_email) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<bool> saveName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_name, value));
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_name) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<bool> saveOTP(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_OTP, value));
  }

  Future<String> getOTP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_OTP) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<bool> saveRegisteredPhoneNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_registeredPhoneNumber, value));
  }

  Future<String> getRegisteredPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_registeredPhoneNumber) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<bool> savePhoneVerifiedAt(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_phoneVerifiedAt, value));
  }

  Future<String> getPhoneVerifiedAt() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_phoneVerifiedAt) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<bool> saveProfileImage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.setString(_profileImage, value));
  }

  Future<String> getProfileImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_profileImage) ?? '';

    print("GET TOKEN");
    print(value);
    return value;
  }

  Future<void> deleteUserAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_Token);
    prefs.remove(_UserID);
    // prefs.remove(_IsGetStarted);
    prefs.remove(_email);
    prefs.remove(_phoneVerifiedAt);
  }

  Future<void> logOutUserAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_Token);
    prefs.remove(_UserID);
    prefs.remove(_phoneVerifiedAt);
  }

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_Token);
  }

  Future<bool> setFCMToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("setFCMToken");
    print(value);
    return (prefs.setString(_fcmToken, value));
  }

  Future<String> getFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(_fcmToken) ?? '';

    print("GET getFCMToken ");
    print(value);
    return value;
  }
}
