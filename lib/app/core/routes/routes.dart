import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';

class Routes {
  static keyboadClose() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static darkStatusbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ));
  }

  static lightStatusbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
  }

  static exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    }
  }

  static pushSimpleAndRemove(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    keyboadClose();
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => WillPopScope(
            child: child,
            onWillPop: () async {
              if (Navigator.of(context).userGestureInProgress) {
                return false;
              } else {
                return true;
              }
            },
          ),
        ),
        (Route<dynamic> route) => false);
  }

  static gotoLogin(
    BuildContext context, {
    Map<String, dynamic>? data,
  }) async {
    Routes.pushSimpleAndRemove(
        child: LoginView(), context: GlobalVariable.getRootContext());
  }

  static pushSimple({
    required BuildContext context,
    required Widget child,
    Function(dynamic)? onBackPress,
  }) {
    Routes.keyboadClose();
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  return true;
                },
              ),
          settings: RouteSettings(name: child.runtimeType.toString())),
    ).then((value) => {
          if (onBackPress != null) {onBackPress(value)}
        });
  }

  static pushSimpleRootNav({
    required BuildContext context,
    required Widget child,
    Function(String?)? onBackPress,
  }) {
    Navigator.of(context)
        .push(
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
          settings: RouteSettings(name: child.runtimeType.toString())),
    )
        .then((value) {
      if (onBackPress != null) {
        onBackPress(value);
      }
    });
  }

  static presentSimple(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
          fullscreenDialog: true),
    ).then((value) {
      if (onBackPress != null) {
        onBackPress(value);
      }
    });
  }

  static pushSimpleAndReplaced(
      {required BuildContext context,
      required Widget child,
      Function(String)? onBackPress}) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
          builder: (context) => WillPopScope(
                child: child,
                onWillPop: () async {
                  if (Navigator.of(context).userGestureInProgress) {
                    return false;
                  } else {
                    return true;
                  }
                },
              ),
          settings: RouteSettings(name: child.runtimeType.toString())),
    );
  }

  static gotoMainScreen(
    BuildContext context, {
    Map<String, dynamic>? data,
  }) {
    Routes.pushSimpleAndRemove(
        child: HomeScreenView(), context: GlobalVariable.getRootContext());
  }

  // static gotoLoginScreen() async {
  //   await LocalStore().removeAll();
  //   await LocalStore().saveUserToken("");

  //   Routes.pushSimpleAndReplaced(
  //       context: GlobalVariable.getRootContext(), child: LoginPageView());
  // }

  // static gotoLoginScreenwithBackButton() async {
  //   await LocalStore().removeAll();
  //   await LocalStore().saveUserToken("");
  //   Routes.pushSimple(
  //       context: GlobalVariable.getRootContext(), child: LoginPageView());
  // }

  // static popToSpecificWidget({
  //   required Widget child,
  // }) async {
  //   Navigator.of(GlobalVariable.getRootContext()).popUntil((route) {
  //     return route.settings.name == child.runtimeType.toString();
  //   });
  // }
}
