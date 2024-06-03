import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';

class PhoneTFView extends StatefulWidget {
  Function(String)? onTap;

  PhoneTFView(
      {super.key,
      required this.controller,
      this.onTap,
      this.errorMsg,
      this.noNeedTitle = false});

  String? errorMsg;
  bool? noNeedTitle;

  TextEditingController controller;
  @override
  State<PhoneTFView> createState() => _PhoneTFViewState();
}

class _PhoneTFViewState extends State<PhoneTFView> {
  String country_code = "91";
  String country_flag = "🇮🇳";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.noNeedTitle == false)
            ? Text(
                ConstantText.phnNumber,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(57, 57, 57, 1)),
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        Container(
          // height: 45,
          // width: 300,

          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColor.textFeildBdr
                  //                   <--- border width here
                  ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  showPicker();
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: 50,
                      height: 40,
                      child: Text(
                        country_flag,
                        style:
                            TextStyle(fontFamily: 'NunitoSans', fontSize: 28),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      width: 50,
                      child: Text(
                        "+${country_code}",
                        style: TextStyle(
                            fontFamily: 'NunitoSans',
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.56,
                // width: 260,
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  //  autofocus: true,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "0000000000",
                      helperStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(57, 57, 57, 1))),
                ),
              ),
            ],
          ),
        ),
        if (widget.errorMsg!.trim() != "")
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
                  widget.errorMsg ?? "",
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

  void showPicker() {
    return showCountryPicker(
        showPhoneCode: true,
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: 20,
          backgroundColor: Colors.white,
          textStyle:
              TextStyle(fontSize: 16, color: Color.fromRGBO(57, 57, 57, 1)),
          bottomSheetHeight: 500, // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: ConstantText.search,
            hintText: ConstantText.startSearch,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          setState(() {
            print(
                'Select country: ${country.displayName},Codeee ${country.phoneCode},falgg ${country.flagEmoji}');
            country_code = country.phoneCode;
            widget.onTap!(country_code);
            print("codee11: ${country_code}");
            country_flag = country.flagEmoji;
            print("codee11flag: ${country_flag}");
          });
        });
  }
}
