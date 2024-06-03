import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/changePasswordForm/component/changePasswordForm.dart';
import 'package:foodorder/app/modules/changePasswordForm/manager/changePasswordManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePassViewState();
}

class _ChangePassViewState extends State<ChangePasswordView> {
  var manager = ChangeManager();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: CustomHomeIconAppBar(
            title: ConstantText.changePassword,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ChangePasswordForm(
                  manager: manager,
                  onRefresh: () {
                    setState(() {});
                  },
                  changePassAction: () {
                    print('CHANGE PASSWORD');
                    manager.validChangePassForm(onRefresh: () {
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
