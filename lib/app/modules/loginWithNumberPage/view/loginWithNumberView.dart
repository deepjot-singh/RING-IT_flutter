import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/changePasswordForm/view/changePasswordView.dart';
import 'package:foodorder/app/modules/checkOutPage/view/checkoutPageView.dart';
import 'package:foodorder/app/modules/deleteAccountPage/view/deleteAccountView.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/components/DontHaveAccComponent.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/manager/loginWithNumberManager.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/remoteServices/loginWithNumberApi.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/remoteServices/loginWithNumberApi.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/remoteServices/loginWithNumberApi.dart';
import 'package:foodorder/app/modules/notificationPage/view/notificationPageView.dart';
import 'package:foodorder/app/modules/settingPage/view/settingView.dart';
import 'package:foodorder/app/widgets/CustomTF/passTF.dart';
import 'package:foodorder/app/widgets/CustomTF/phoneTF.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/forgotPasswordPage/view/forgotPasswordView.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';
import 'package:foodorder/app/widgets/socialLoginBtn/socialLoginBtn.dart';
import '../../../widgets/CustomTF/passwordTF.dart';
import '../../changePasswordForm/manager/changePasswordManager.dart';
import '../../restaurantListPage/view/restaurantListView.dart';
import '../../signUpPage/view/signUpView.dart';
import '../../singleRestaurantPage/view/singleResaturantPage.dart';
import 'package:foodorder/app/modules/loginPage/manager/socialLoginManager.dart';

class PhoneNumberLoginView extends StatefulWidget {
  @override
  State<PhoneNumberLoginView> createState() => _PhoneNumberLoginViewState();
}

class _PhoneNumberLoginViewState extends State<PhoneNumberLoginView> {
  var manager = LoginWithNumberManager();
  var socialLogin = SocialLoginManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomHomeIconAppBar(
      //     // title: ConstantText.login,
      //     ),
      body: SafeArea(child: bodyView(context)),
    );
  }

  Widget bodyView(BuildContext context) {
    var code;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
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
              PhoneTFView(
                controller: manager.phoneTf,
                errorMsg: manager.phoneNumberErrorMsg,
                onTap: (value) {
                  manager.code = value;
                  manager.countryCodeTF.text = manager.code;
                  print("controllr${code}");

                  print("controllr${manager.countryCodeTF}");
                }, // ADD PHONE CONTROLLER HERE
              ), //PHONE TEXTFLIEDj
              SizedBox(
                height: 20,
              ),
              PasswordTF(
                password: true,
                controllr: manager.passwordTF,
                topTitle: ConstantText.pass,
                obscureText: manager.obscureTextNewConf,
                errorMsg: manager.passwordErrorMsg,
                fontSize: 17,
                placeholder: ConstantText.passwordPlaceholder,
                onChange: (text) {},
                onChangeObsecure: (value) {
                  manager.obscureTextNewConf = value;
                  setState(() {});
                },
              ),
              // PASSWORD TEXTFEILD
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ForgetPasswordView())); // NAVIGATE TO FORGET PASSWORD SCREEN
                  },
                  child: Text(
                    ConstantText.forgetPass,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(57, 57, 57, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton.regular(
                background: AppColor.redThemeColor,
                title: ConstantText.signIn,
                fontSize: 16,
                radius: 10,
                fontweight: FontWeight.bold,
                onTap: () {
                  print("signin");
                  manager.validation(
                      context: context,
                      onRefresh: () {
                        setState(() {});
                      });
                },
              ), // SUBMIT BUTTON FOR LOGIN
              SizedBox(
                height: 20,
              ),
              Center(
                child: DontHaveAccComponent(
                  title1: ConstantText.dontHaveAcc,
                  title2: ConstantText.createAcc,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpView(
                                  onRefresh: () {
                                    setState(() {});
                                  },
                                  registerAction: () {
                                    setState(() {});
                                  },
                                ))); // NAVIGATE TO FORGET SIGNUP SCREEN
                  },
                ),
              ), // Dont have a Account
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  ConstantText.or,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(57, 57, 57, 1)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: SocialLoginButton(
                    needIcon: true,
                    type: SocialButtonType.google,
                    bdrColor: AppColor.blueBtn,
                    title: ConstantText.googleBtn,
                    background: Colors.blueAccent,
                    onTap: () {
                      Routes.keyboadClose();
                      socialLogin.googleSignIn(context);
                    }), // LOGIN WITH GOOGLE BUTTON
              ),
              SizedBox(
                height: 15,
              ),
              if (Platform.isIOS) ...[
                Center(
                  child: SocialLoginButton(
                    needIcon: true,

                    // bdrColor: Colors.black ,
                    type: SocialButtonType.apple,
                    title: ConstantText.appleBtn,
                    background: Colors.black,
                    onTap: () {
                      socialLogin.appleLogin(context);
                    },
                  ), // LOGIN WITH APPLE BUTTON
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
