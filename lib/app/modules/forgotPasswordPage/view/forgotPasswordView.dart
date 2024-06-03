import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:foodorder/app/widgets/CustomTF/phoneTF.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';

import '../manager/forgotPassManager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  var manager = ForgotPasswordManager();
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CustomHomeIconAppBar(
          title: ConstantText.forgotpass,
        ),
        body: bodyView(context),
      ),
    );
  }

  Widget bodyView(BuildContext context ) {
   
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
          ),
          PhoneTFView(
            controller: manager.phoneNumberTF, // ADD PHONE CONTROLLER HER
            errorMsg: manager.phoneNumberErrorMsg,
            onTap: (value) {
              manager.code = value;
              manager.countryCodeTF.text = manager.code;
         
              print("controllr${manager.countryCodeTF}");
            },
          ),
          SizedBox(
            height: 70,
          ),
          CustomButton.regular(
            title: ConstantText.resetPass.toUpperCase(),
            background: AppColor.redThemeColor,
            onTap: () {
              manager.validation(
                  context: context,
                  onRefresh: () {
                    setState(() {});
                  });
            },
          ),
        ],
      ),
    );
  }
}
