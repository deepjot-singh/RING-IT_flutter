import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';

class ClearBtnComponent extends StatelessWidget {
  ClearBtnComponent({super.key, required this.onTap});
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text(
          ConstantText.clearFilter,
          style: TextStyle(
            fontFamily: "NunitoSans",
            fontSize: 14,
            color: AppColor.redThemeClr,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          onTap();
        },
      ),
    );
  }
}
