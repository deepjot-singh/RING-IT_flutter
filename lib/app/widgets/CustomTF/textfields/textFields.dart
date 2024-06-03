import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';

class TextFieldComponent extends StatelessWidget {
  double height = 50;
  var controllr = TextEditingController();
  String placeholder = "";
  // int maxLength;
  //Color background;
  // Color titleColor;
  bool enabled;
  bool password;
  int? maxlines;
  String label;

  Widget? rightIcon;
  Widget? leftIcon;
  String errorMsg;
  Color? placeholderColor;
  TextInputType keyBoardType;
  Function(String)? onChange;
  bool neededInputFormat;
  TextFieldComponent(
      {this.password = false,
      this.maxlines = 1,
      this.neededInputFormat = false,
      this.rightIcon,
      this.leftIcon,
      this.errorMsg = "",
      required this.label,
      //this.width = double.infinity,
      required this.controllr,
      this.keyBoardType = TextInputType.text,
      this.height = 50,
      this.placeholder = "",
      this.placeholderColor,

      // this.background,
      // this.titleColor,

      this.enabled = true,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(color: AppColor.blackstd, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: height,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.textFeildBdr
                    //color: AppColor.textBlackColor
                    //                   <--- border width here
                    ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: TextField(
                  cursorColor: Colors.black,
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: maxlines ?? 1,
                  controller: controllr,
                  style:
                      const TextStyle(fontFamily: 'NunitoSans', fontSize: 16),
                  onChanged: (text) {
                    if (onChange != null) {
                      onChange!(text);
                    }
                  },
                  keyboardType: keyBoardType,
                  inputFormatters: [
                    if (neededInputFormat)
                      FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: placeholder,
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: leftIcon,
                  ),
                  autofocus: false,
                  enabled: enabled,
                ))),
        if (errorMsg.trim() != "")
          Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Container(
              // color: Colors.red.withOpacity(0.3),
              child: Padding(
                padding: EdgeInsets
                    .zero, //EdgeInsets.fromLTRB(10.sp, 5.sp, 10.sp, 5.sp),
                child: Text(
                  errorMsg ?? "",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
