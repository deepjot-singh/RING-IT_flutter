import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/resetPassword/component/ResetPassForm.dart';
import 'package:foodorder/app/modules/resetPassword/manager/resetPasswordManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPassViewState();
}

class _ResetPassViewState extends State<ResetPasswordView> {
  var manager = ResetPasswordManager();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: CustomHomeIconAppBar(
            title: ConstantText.createNewPass,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ResetPasswordForm(
                  manager: manager,
                  onRefresh: () {
                    setState(() {});
                  },
                  resetPassAction: () {
                    print('CHANGE PASSWORD');
                    manager.validResetPasswordForm(onRefresh: () {
                      setState(() {});
                    });
                  },
                )
              ],
            ),
          )),
    );
  }
}
