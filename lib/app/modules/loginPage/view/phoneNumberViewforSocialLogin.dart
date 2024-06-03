import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/loginPage/manager/socialLoginManager.dart';
import 'package:foodorder/app/widgets/CustomTF/phoneTF.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';

class PhoneNumberLoginViewForSocial extends StatefulWidget {
  const PhoneNumberLoginViewForSocial({super.key});

  @override
  State<PhoneNumberLoginViewForSocial> createState() =>
      _PhoneNumberLoginViewForSocialState();
}

class _PhoneNumberLoginViewForSocialState
    extends State<PhoneNumberLoginViewForSocial> {
  var manager = SocialLoginManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(
        title: ConstantText.login,
      ),
      body: bodyView(context),
    );
  }

  Widget bodyView(BuildContext context) {
    var code;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 90,
          ),
          PhoneTFView(
            controller: manager.phoneNumberTF, // ADD PHONE CONTROLLER HER
            errorMsg: manager.phoneNumberErrorMsg,
            onTap: (value) {
              code = value;
              manager.countryCode = "+$code";
            },
          ),
          const SizedBox(
            height: 70,
          ),
          CustomButton.regular(
            background: AppColor.redThemeColor,
            shadow: false,
            borderWidth: 0,
            fontSize: 16,
            radius: 10,
            fontweight: FontWeight.bold,
            title: ConstantText.signIn.toUpperCase(),
            onTap: () {
              manager.validation(onRefresh: () {
                setState(() {});
              });
            },
          ),
        ],
      ),
    );
  }
}
