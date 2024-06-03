import 'package:flutter/material.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressProvider/addAddressProvider.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/profile/provider/profileProvider.dart';

class GlobalVariable {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // static GlobalManager globarProviderManager = GlobalManager();

  // static ScrimmageManager startSliderScrimmageManager = ScrimmageManager();
  static AddressProvider addressProviderManager = AddressProvider();
  static ProductProvider productProviderManager = ProductProvider();
  static ProfileProvider ProfileProviderManager = ProfileProvider();
  static getRootContext() {
    return GlobalVariable.navigatorKey.currentState!.context;
  }

  static var isRunningLoader = false;
  static var start = "1";
  static var finish = "2";
  static var layoutHorizontalPadding = 30.0;
  static ScaffoldMessengerState? scaffoldMessengerState;
}
