import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  Widget? _widget;

  SplashView({super.key, required Widget? navigateRoute}) {
    _widget = navigateRoute;
  }

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),

        () => Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (BuildContext context) => widget._widget!)));
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => OnboardingView())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.redThemeColor,
      child: Center(
          child: Lottie.asset(
        "assets/animations/animation-splash.json",
      )),
    );
  }
}
