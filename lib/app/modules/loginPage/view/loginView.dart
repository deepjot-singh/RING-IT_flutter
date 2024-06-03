import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/loginPage/manager/socialLoginManager.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/manager/loginWithNumberManager.dart';
import 'package:foodorder/app/modules/loginWithNumberPage/view/loginWithNumberView.dart';
import 'package:foodorder/app/widgets/socialLoginBtn/socialLoginBtn.dart';
import 'dart:io' show Platform;

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var manager3 = LoginWithNumberManager();
  var socialLogin = SocialLoginManager();
  var appleAuthorizationToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: null,
      //CustomHomeIconAppBar(title: ConstText.googleBtn ,),
      body: bodyView(),
    );
  }

  // appleLogin() async {
  //   print("APPLELOGIN");
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //     appleAuthorizationToken = credential.authorizationCode;
  //     print("APPLELOGIN111 ${credential.userIdentifier}");
  //   } catch (e) {
  //     print("ERROR-> $e");
  //   }
  // }

  var test = "";
  @override
  // void initState () async{
  //   // TODO: implement initState
  //   super.initState();
  //      test = await LocalStore().getIsGetStarted();
  //   print('tetst is here ${test}');
  // }

  Widget bodyView() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              opacity: 0.4,
              image: AssetImage("assets/images/loginBg.png"),
              fit: BoxFit.cover,
            )),
        alignment: Alignment.center,
        //color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/images/logowhite.png",
                width: 180,
                height: 78,
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   ConstantText.zoom,
              //   style: TextStyle(
              //       fontFamily: 'NunitoSans',
              //       fontSize: 20,
              //       fontWeight: FontWeight.w800,
              //       color: Colors.white),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                ConstantText.zoomdesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(189, 188, 188, 1)),
              ),

              Spacer(),
              SocialLoginButton(
                  needIcon: true,
                  type: SocialButtonType.google,
                  bdrColor: AppColor.blueBtn,
                  title: ConstantText.googleBtn,
                  background: Colors.blueAccent,
                  onTap: () {
                    socialLogin.googleSignIn(context);
                  }), // GOOGLE LOGIN BUTTON
              SizedBox(
                height: 15,
              ),
              if (Platform.isIOS) ...[
                InkWell(
                  onTap: () {
                    socialLogin.appleLogin(context);
                  },
                  child: SocialLoginButton(
                    needIcon: true,
                    // bdrColor: Colors.black ,
                    type: SocialButtonType.apple,
                    title: ConstantText.appleBtn,
                    background: Colors.black,
                    onTap: () {
                      socialLogin.appleLogin(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],

              // APPLE LOGIN BUTTON

              SocialLoginButton(
                needIcon: true,
                type: SocialButtonType.number,
                bdrColor: AppColor.orangeBrown,
                title: ConstantText.numberBtn,
                background:
                    // AppColor.redlight,
                    AppColor.redThemeColor,
                onTap: () {
                  Routes.pushSimpleAndReplaced(
                      context: GlobalVariable.getRootContext(),
                      child:
                          PhoneNumberLoginView()); // NAVIGATE TO LOGIN WITH NUMBER SCREEN
                },
              ), // LOGIN WITH NUMBER BUTTON
              SizedBox(
                height: 15,
              ),
              SocialLoginButton(
                needIcon: false,
                bdrColor: Colors.white,
                title: ConstantText.guest,
                //titleColor: Colors.black,
                // background:Colors.blueAccent,
                onTap: () {
                  Routes.pushSimpleAndReplaced(
                      context: GlobalVariable.getRootContext(),
                      child: HomeScreenView());
                },
              ),
            ],
          ),
        ));
  }
} // BODY VIEW
