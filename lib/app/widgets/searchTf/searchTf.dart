import 'package:flutter/material.dart';

class SearchTF extends StatefulWidget {
  // double width = 100;
  double height = 50;
  var controllr = TextEditingController();
  String placeholder = "";
  // int maxLength;
  Color? background;
  // Color titleColor;
  bool obscureText;
  bool enabled;
  bool password;
  int maxlines;
  Widget? rightIcon;
  Widget? leftIcon;
  TextInputType keyBoardType;

  Function(String)? onChange;
  SearchTF(
      {this.password = false,
      this.maxlines = 1,
      this.background,
      this.rightIcon,
      this.leftIcon,
      //this.width = double.infinity,
      required this.controllr,
      this.keyBoardType = TextInputType.text,
      this.height = 44,
      this.placeholder = "",

      // this.background,
      // this.titleColor,
      this.obscureText = false,
      this.enabled = true,
      this.onChange});

  @override
  State<SearchTF> createState() => _SearchTFState();
}

class _SearchTFState extends State<SearchTF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: widget.background ?? Color.fromRGBO(232, 232, 232, 1),
          // boxShadow: [
          //   // ignore: unnecessary_new
          //   new BoxShadow(
          //       color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.3),
          // ],
          border: Border.all(width: 0.4, color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: widget.leftIcon != null ? 0 : 0),
          child: TextField(
            maxLines: widget.maxlines,
            controller: widget.controllr,
            style: const TextStyle(fontSize: 16),
            onChanged: (text) => {
              widget.onChange!(text),
              setState(() {
                //refresh UI
              })
            },
            keyboardType: widget.keyBoardType,
            decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(
                    Icons.search,
                    size: 15,
                    color: Colors.grey,
                  ),
                ),
                border: InputBorder.none,
                hintStyle: const TextStyle(fontSize: 16),
                hintText: widget.placeholder,
                suffixIcon: widget.controllr.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          //add Icon button at end of TextField
                          widget.controllr.clear();
                          widget.onChange!("");
                          setState(() {
                            //refresh UI
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 15,
                        ),
                      )),
            autofocus: false,
            enabled: widget.enabled,
            obscureText: widget.obscureText,
          ),
        ),
      ),
    );
  }
}
