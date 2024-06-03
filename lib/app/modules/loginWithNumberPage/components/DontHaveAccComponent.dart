import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';

import '../../../core/appColor/appColor.dart';

class DontHaveAccComponent extends StatelessWidget {
  DontHaveAccComponent(
      {super.key,
      required this.title1,
      required this.title2,
      required this.onTap});
  String title1;
  String title2;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: RichText(
          text: TextSpan(
            text: title1,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(57, 57, 57, 1),
            ),
            children: [
              TextSpan(
                  text: title2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    //color: AppColor.textBlackColor,
                    color: AppColor.redThemeClr,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
