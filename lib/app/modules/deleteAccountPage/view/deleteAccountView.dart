import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/deleteAccountPage/manager/deleteAccountManager.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  var manager = DeleteAccountManager();
  final String html = """
  <p style= text-align:center>
  We're sad to see you go! Before you leave, please let us know if there's anything we can improve. Remember, deleting your account is permanent and will remove all your data, including.

  <br><br>
  If you decide to return in the future, you'll need to create a new account. We won't be able to recover your data once your account is deleted.</p>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(
        title: ConstantText.deleteAccount,
        needBackIcon: false,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                  child: Image.asset(
                "assets/images/deleteAccount.png",
                height: 120,
              )),
              const SizedBox(
                height: 40,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    html,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CustomButton.regular(
                      width: double.infinity,
                      height: 50,
                      background: AppColor.redThemeColor,
                      title: ConstantText.deleteAccount.toUpperCase(),
                      shadow: false,
                      borderWidth: 0,
                      fontSize: 16,
                      radius: 10,
                      fontweight: FontWeight.bold,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(ConstantText.deleteAccount),
                              content: Text(ConstantText.deleteAccountText,
                                  style: TextStyle(fontSize: 14)),
                              actions: <Widget>[
                                Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.redThemeClr),
                              child: TextButton(
                                child: const Text(ConstantText.cancel,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.redThemeColor),
                              child: TextButton(
                                child: const Text(ConstantText.confirm,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  var manager = DeleteAccountManager();
                                  manager.deleteAccount();
                                  dismissWaitDialog();
                                },
                              ),
                            ),
                                // TextButton(
                                //   child: const Text(ConstantText.confirmOption),
                                //   onPressed: () {
                                //     manager.deleteAccount();
                                //   },
                                // ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
