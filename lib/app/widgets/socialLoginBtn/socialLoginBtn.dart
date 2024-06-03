// SOCIAL LOGIN BUTTONS

import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';

enum SocialButtonType {
  google,
  apple,
  guest,
  number;
}

class SocialLoginButton extends StatelessWidget {
  double width = 100;
  double height = 100;
  double fontSize = 17;
  SocialButtonType type;
  String title = "";
  bool? needIcon;
  Color? background;
  Color? bdrColor;
  Color? titleColor;
  double? radius;
  VoidCallback? onTap;
  FontWeight fontweight;

  SocialLoginButton(
      {super.key,
      this.type = SocialButtonType.number,
      this.width = double.infinity,
      this.needIcon,
      this.height = 44,
      this.title = "",
      this.fontSize = 18,
      this.radius = 8,
      this.background,
      this.titleColor,
      this.bdrColor,
      this.onTap,
      this.fontweight = FontWeight.w400});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: bdrColor ?? Colors.transparent
                //                   <--- border width here
                ),
            borderRadius: BorderRadius.circular(radius ?? 20),
            color: background ?? Colors.transparent),
        clipBehavior: Clip.antiAlias,
        child: Center(
            child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            if (needIcon == true)
              if (type == SocialButtonType.number)
                Image.asset(
                  "assets/icons/call.png",
                  width: 25,
                  height: 25,
                ),
            if (type == SocialButtonType.google)
              Image.asset(
                "assets/icons/google.png",
                width: 25,
                height: 25,
              ),
            if (type == SocialButtonType.apple)
              Image.asset(
                "assets/icons/apple.png",
                width: 25,
                height: 25,
              )
            else ...[Container()],
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.bold,
                    //color: titleColor ?? AppColor.textBlackColor,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Spacer(),
          ],
        )),
      ),
    );
  }
}
