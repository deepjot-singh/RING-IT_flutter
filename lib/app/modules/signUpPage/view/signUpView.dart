import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodorder/app/modules/otherInformationPages/view/otherInformationPageView.dart';
import 'package:foodorder/app/modules/signUpPage/manager/signUpManager.dart';

import '../../../core/appColor/appColor.dart';
import '../../../core/constant/constText.dart';
import '../../../widgets/CustomTF/passTF.dart';
import '../../../widgets/CustomTF/passwordTF.dart';
import '../../../widgets/CustomTF/phoneTF.dart';
import '../../../widgets/appBar/customAppBar.dart';
import '../../../widgets/customBtn/customBtn.dart';
import '../../../widgets/socialLoginBtn/socialLoginBtn.dart';
import '../../changePasswordForm/manager/changePasswordManager.dart';
import '../../loginWithNumberPage/components/DontHaveAccComponent.dart';
import '../../loginWithNumberPage/view/loginWithNumberView.dart';
import 'package:foodorder/app/modules/loginPage/manager/socialLoginManager.dart';

class SignUpView extends StatefulWidget {
  SignUpView(
      {super.key, required this.registerAction, required this.onRefresh});
  Function() registerAction;
  Function() onRefresh;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var manager = SignUpManager();
  var socialLogin = SocialLoginManager();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        // appBar: CustomHomeIconAppBar(
        //   title: ConstantText.creteAcc,
        // ),
        body: bodyView(context),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    var code;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Image.asset(
                "assets/images/logowhite.png",
                color: Colors.black,
                height: 50,
              ),
            ),
            SizedBox(
              height: 50,
            ),

            Text(
              ConstantText.createAcc.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(57, 57, 57, 1),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            PasswordTF(
              password: false,
              controllr: manager.nameTf,

              topTitle: ConstantText.fullName,
              obscureText: false,
              errorMsg: manager.errorMsgNameText,
              fontSize: 17,
              placeholder: "Enter Name",
              // onChange: (text) {},
              // onChangeObsecure: (value) {
              //   manager.obscureTextNewConf = value;
              //   setState(() {});
              // },
            ),

            // FULL NAME  TEXTFEILD
            SizedBox(
              height: 20,
            ),
            PhoneTFView(
              controller: manager.phoneTf,
              errorMsg: manager.phoneNumberErrorMsg,
              onTap: (value) {
                manager.code = value;
                manager.countryCodeTf.text = manager.code;
              }, // ADD PHONE CONTROLLER HER
            ), //PHONE TEXTFLIED
            SizedBox(
              height: 20,
            ),
            PasswordTF(
              password: true,
              controllr: manager.newPassTF,
              topTitle: ConstantText.pass,
              obscureText: manager.obscureTextNewConf,
              errorMsg: manager.errorMsgNewPassConf,
              fontSize: 17,
              placeholder: ConstantText.passwordPlaceholder,
              onChange: (text) {},
              onChangeObsecure: (value) {
                widget.onRefresh();
                manager.obscureTextNewConf = value;
                setState(() {});
              },
            ), // PASSWORD TEXTFEILD
            SizedBox(
              height: 20,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text.rich(TextSpan(children: <InlineSpan>[
                  TextSpan(
                    text: ConstantText.bySigningAgree,
                    style: const TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(57, 57, 57, 1)),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtherInformationPageView(
                                type: "term_and_condition"),
                          ),
                        );
                      },
                      child: Text(
                        ConstantText.termsText,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.redThemeClr),
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: "&",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(57, 57, 57, 1)),
                  ),
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtherInformationPageView(
                                type: "privacy_policy"),
                          ),
                        );
                      },
                      child: Text(
                        ConstantText.conditionNprivacy,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColor.redThemeClr),
                      ),
                    ),
                  ),
                ]))),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            CustomButton.regular(
              title: ConstantText.signUp,
              fontSize: 16,
              radius: 10,
              fontweight: FontWeight.bold,
              background: AppColor.redThemeColor,
              onTap: () {
                // widget.registerAction();
                manager.validRegistrationForm(
                    context: context,
                    onRefresh: () {
                      setState(() {});
                    });
              },
            ), // SUBMIT BUTTON FOR LOGIN

            SizedBox(
              height: 10,
            ),
            InkWell(
                child: Text(
                  ConstantText.alreadyAcc,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.redThemeClr),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhoneNumberLoginView())); // NAI
                }),
            // DontHaveAccComponent(
            //   title1: "",
            //   title2: ConstantText.alreadyAcc,
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 PhoneNumberLoginView())); // NAIGATE TO LOGIN SCREEN
            //   },
            // ),
            SizedBox(
              height: 20,
            ),

            Center(
              child: Text(
                ConstantText.or,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(1, 15, 7, 1)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SocialLoginButton(
                  needIcon: true,
                  type: SocialButtonType.google,
                  bdrColor: AppColor.blueBtn,
                  title: ConstantText.googleBtn,
                  background: Colors.blueAccent,
                  onTap: () {
                    socialLogin.googleSignIn(context);
                  }), // LOGIN WITH GOOGLE BUTTON
            ),
            SizedBox(
              height: 10,
            ),
            if (Platform.isIOS) ...[
              Center(
                child: SocialLoginButton(
                  needIcon: true,
                  // bdrColor: Colors.black ,
                  type: SocialButtonType.apple,
                  title: ConstantText.appleBtn,
                  background: Colors.black,
                  onTap: () {},
                ), // LOGIN WITH APPLE BUTTON
              ),
            ]
          ],
        ),
      ),
    );
  }
}
