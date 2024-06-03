import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/remoteServices/loginWithNumberApi.dart';
import 'package:foodorder/app/modules/otpVerify/manager/otpManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import '../../../widgets/customBtn/customBtn.dart';
import '../../loginWithNumberPage/components/DontHaveAccComponent.dart';

class OTPVerifyView extends StatefulWidget {
  OTPVerifyView(
      {super.key,
      this.userPhoneNumber = "",
          this.country_code = "",
      this.isForgotPassword = false,
      this.showTermText = true});

  bool isForgotPassword = false;
  bool showTermText = true;
String? country_code ;
  String? userPhoneNumber;

  @override
  State<OTPVerifyView> createState() => _OTPVerifyViewState();
}

class _OTPVerifyViewState extends State<OTPVerifyView> {
  var manager = OtpManager();
  Timer? timer;
  var start = 90;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getUserDetail();
      startTimer();
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              start--;
            });
          }
        }
      },
    );
  }

  var userId;
  var otp = "";
  getUserDetail() async {
    userId = await LocalStore().getUserID();
    otp = await LocalStore().getOTP();
    print("mmmmmmm--$otp");
    start = 90;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CustomHomeIconAppBar(
          title: ConstantText.verfiyNumber,
        ),
        body: bodyView(context),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),

          Text(
            ConstantText.enter4digitNumber+widget.country_code!+widget.userPhoneNumber!,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),

          const SizedBox(
            height: 50,
          ),

          Text(
            otp,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          const SizedBox(
            height: 50,
          ),
          OtpTextField(
            numberOfFields: 4,

            cursorColor: Colors.black,
            // borderColor: Colors.black,
            showFieldAsBox: false,
            focusedBorderColor: Colors.black,
            onSubmit: (value) {
              print("onSubmit${value}");
              manager.otpCodeTF = value;
            },
            onCodeChanged: (String code) {
              print('code $code');
              manager.otpCodeTF = code;
            },
          ),
          if (manager.otpErrorMsg != "") ...[
            Text(
              manager.otpErrorMsg,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red),
            )
          ],
          //  writeReview(),
          const SizedBox(
            height: 50,
          ),
          CustomButton.regular(
            title: ConstantText.verify.toUpperCase(),
            background: AppColor.redThemeColor,
            fontSize: 16,
            radius: 10,
            fontweight: FontWeight.bold,
            onTap: () {
              manager.validation(
                  onRefresh: () {
                    setState(() {});
                  },
                  isForgotPassword: widget.isForgotPassword);
            },
          ),
          const SizedBox(
            height: 20,
          ),

          Center(
              child: DontHaveAccComponent(
            title1: ConstantText.DidntRecviveOtp,
            title2: start != 0 ? "$start seconds" : ConstantText.resendAgain,
            onTap: () {
              if (start == 0) {
                manager.resendOtpApi(onRefresh: () {
                  getUserDetail();
                  setState(() {});
                });
                startTimer();
              }
            },
          )),
          const SizedBox(
            height: 90,
          ),
          // widget.showTermText ?
          // Center(
          //   child: Text(
          //     ConstantText.bySigningAgree,
          //     style: const TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w700,
          //         color: Color.fromRGBO(57, 57, 57, 1)),
          //   ),
          // ):Container(),
          // widget.showTermText ?
          // Center(
          //   child: Text(
          //     ConstantText.conditionNprivacy,
          //     style: const TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w700,
          //         color: Color.fromRGBO(57, 57, 57, 1)),
          //   ),
          // ) : Container(),
        ]),
      ),
    );
  }
}
