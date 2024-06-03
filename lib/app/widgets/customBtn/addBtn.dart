import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';

class AddBtnComponent extends StatelessWidget {
  const AddBtnComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 25,
    width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColor.redThemeClr, width: 1.5)
      ),
      child: Center(
        child: Text(
          ConstantText.add,
          style: TextStyle(
              fontSize: 12,
            color: AppColor.redThemeClr,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
