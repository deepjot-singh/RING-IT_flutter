import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';

class SettingTitleComponent extends StatelessWidget {
  SettingTitleComponent({
    super.key,
    required this.title,
  });
  String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColor.settingTextColor),
    );
  }
}
