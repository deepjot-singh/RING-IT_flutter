import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';

class PasswordTF extends StatelessWidget {
  // double width = 100;
  double height = 50;
  double fontSize = 15;
  var controllr = TextEditingController();
  String placeholder = "";
  String errorMsg = "";
  EdgeInsets? contentPandding;
  // int maxLength;
  //Color background;
  // Color titleColor;
  bool obscureText;
  // bool obsecureTextConf;
  bool enabled;
  bool password;
  bool validate;

  int maxlines;
  Widget? rightIcon;
  Widget? leftIcon;
  TextInputType keyBoardType;
  Function(String)? onChange;
  Function(bool)? onChangeObsecure;
  String topTitle = "";
  PasswordTF({
    required this.password,
    this.maxlines = 16,
    this.rightIcon,
    this.errorMsg = "",
    this.topTitle = "",
    this.validate = false,
    this.contentPandding,
    //this.width = double.infinity,
    required this.controllr,
    this.fontSize = 15,
    this.keyBoardType = TextInputType.text,
    this.height = 0,
    this.placeholder = "",

    // this.background,
    // this.titleColor,
    this.obscureText = true,
    this.onChangeObsecure,
    // this.obsecureTextConf = false,
    this.enabled = true,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    print('OBSECURE--${obscureText}');
    if (height == 0) {
      height = 50;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topTitle,
          style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 12,
              color: Color.fromRGBO(57, 57, 57, 1),
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: height,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColor.textFeildBdr
                  //                   <--- border width here
                  ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.only(
                left: leftIcon != null ? 0 : 10,
                right: rightIcon == null && !password ? 10 : 0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: obscureText ? 1 : maxlines,
                    cursorColor: Colors.black,
                    controller: controllr,
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: fontSize,
                      color: Colors.black,
                    ),
                    onChanged: (text) => {onChange!(text)},
                    keyboardType: keyBoardType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: contentPandding,

                      hintText: placeholder,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(57, 57, 57, 1),
                        fontSize: fontSize,
                      ),
                      prefixIcon: leftIcon,
                      // suffixIcon:
                      //     :   rightIcon
                    ),
                    autofocus: false,
                    enabled: enabled,
                    obscureText: obscureText,
                    // obscureText: obscureText == true ? obscureText : false,
                  ),
                ),
                password == true
                    ? IconButton(
                        onPressed: () {
                          print('click');
                          //add rrIcon button at end of TextField

                          //refresh UI
                          if (obscureText) {
                            //if passenable == true, make it false
                            obscureText = false;
                          } else {
                            obscureText =
                                true; //if passenable == false, make it true
                          }
                          onChangeObsecure!(obscureText);
                        },
                        icon: obscureText == true
                            ? Icon(
                                Icons.remove_red_eye,
                                color: Colors.black,
                                size: 20,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.black,
                                size: 20,
                              ))
                    : Container(),
              ],
            ),
          ),
        ),
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
                  errorMsg,
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
