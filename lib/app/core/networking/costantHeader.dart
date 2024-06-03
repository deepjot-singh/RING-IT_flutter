
import 'package:foodorder/app/core/sharedPreference/localStore.dart';

Future<Map<String, String>> tokenHeader() async {
  return {
    "Authorization": await LocalStore().getToken(),
    "content-type": 'application/json',
    //"Cookie": await LocalStore().getLanguage()
  };
}
