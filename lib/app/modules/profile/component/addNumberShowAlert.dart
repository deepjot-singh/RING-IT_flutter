import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/profile/manager/updatePhonemanager.dart';
import 'package:foodorder/app/modules/profile/manager/verifyPhoneNumberManager.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';
import '../../../widgets/CustomTF/phoneTF.dart';

void AddNumberShowBottomPopUp(
    {BuildContext? context, required UpdatePhoneManager updateManager, otp}) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context!,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          final MediaQueryData mediaQueryData = MediaQuery.of(context);
          return SingleChildScrollView(
            child: Padding(
              padding: mediaQueryData.viewInsets,
              child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 150),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        ConstantText.updateNumber,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: PhoneTFView(
                          controller:
                              updateManager.phoneTf, // ADD PHONE CONTROLLER HER
                          errorMsg: updateManager.phoneNumberErrorMsg,
                          onTap: (value) {
                            updateManager.code = value;
                            updateManager.countryCodeTf.text =
                                updateManager.code;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton.regular(
                        height: 50,
                        background: AppColor.redThemeColor,
                        shadow: false,
                        borderWidth: 0,
                        fontSize: 16,
                        radius: 10,
                        fontweight: FontWeight.bold,
                        title: ConstantText.update.toUpperCase(),
                        onTap: () {
                          print("ppppp1");
                          updateManager.validation(
                            context: context,
                            onRefresh: () {
                              print(
                                  'sandhu ${updateManager.phoneNumberErrorMsg}');
                              print('sandhu ${updateManager.countryCodeTf}');
                              setState() {}
                            },
                            // AddOtpShowBottomPopUp(
                            //     // context: context,
                            //     otp: otp,
                            //     otpVerifiedManager:
                            //         updateManager.OTPVerifiedManager);
                            // setState(() {});
                            // phoneNo: phoneTf.text
                          );
                        },
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            ),
          );
        });
      });
}

void AddOtpShowBottomPopUp(
    {BuildContext? context,
    VerifyPhoneNumberManager? otpVerifiedManager,
    required otp}) {
  showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          print("prrrrrr");
          final MediaQueryData mediaQueryData = MediaQuery.of(context);

          return Padding(
            padding: mediaQueryData.viewInsets,
            child: Container(
                height: 200,
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ConstantText.enter4digitNumber,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    OtpTextField(
                      numberOfFields: 4,
                      cursorColor: Colors.black,
                      // borderColor: Colors.black,
                      showFieldAsBox: false,
                      focusedBorderColor: Colors.black,
                      onCodeChanged: (String code) {},
                    ),
                    //  writeReview(),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton.regular(
                      title: ConstantText.Continue,
                      background: Color.fromRGBO(203, 32, 45, 1),
                      onTap: () {
                        // otpVerifiedManager
                        //     .verifyPhoneNumber(otp: otp, onRefresh: ());
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => UpdateProfileView()));
                      },
                    ),
                  ],
                )),
          );
        });
      });
}
