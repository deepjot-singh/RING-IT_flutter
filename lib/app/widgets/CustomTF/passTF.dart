import 'package:flutter/material.dart';

class CustomTF extends StatefulWidget {
  // double width = 100;
  double height = 50;

  var controllr = TextEditingController();
  String placeholder = "";
  // int maxLength;
  //Color background;
  // Color titleColor;
  String title;
  bool obscureText;
  bool enabled;
  bool password;
  int maxlines;
  Widget? rightIcon;
  Widget? leftIcon;
  Color? placeholderColor;
  TextInputType keyBoardType;
  Function(String)? onChange;
  CustomTF(
      {this.password = false,
      this.maxlines = 1,
      this.rightIcon,
      this.leftIcon,
      required this.title,
      //this.width = double.infinity,
      required this.controllr,
      this.keyBoardType = TextInputType.text,
      this.height = 50,
      this.placeholder = "",
      this.placeholderColor,

      // this.background,
      // this.titleColor,
      this.obscureText = false,
      this.enabled = true,
      this.onChange});

  @override
  State<CustomTF> createState() => _CustomTFState();
}

class _CustomTFState extends State<CustomTF> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(57, 57, 57, 1)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(57, 57, 57, 1),
                  width: 1.0,
                ),
              ),
              // borderRadius: BorderRadius.circular(8),
              color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: TextField(
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              maxLines: widget.maxlines,
              controller: widget.controllr,
              style: TextStyle(fontFamily: 'NunitoSans', fontSize: 16),
              onChanged: (text) => {widget.onChange!(text)},
              keyboardType: widget.keyBoardType,
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(color: Color.fromRGBO(57, 57, 57, 1)),
                  prefixIcon: widget.leftIcon,
                  suffixIcon: widget.password == true
                      ? IconButton(
                          onPressed: () {
                            //add Icon button at end of TextField
                            setState(() {
                              //refresh UI
                              if (widget.obscureText) {
                                //if passenable == true, make it false
                                widget.obscureText = false;
                              } else {
                                widget.obscureText =
                                    true; //if passenable == false, make it true
                              }
                            });
                          },
                          icon: Icon(
                            widget.obscureText == true
                                ? Icons.remove_red_eye_rounded
                                : Icons.password,
                            // color: Colors.black,
                          ),
                        )
                      : widget.rightIcon),
              autofocus: false,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
            ),
          ),
        ),
      ],
    );
  }
}
