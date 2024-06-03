import 'package:flutter/cupertino.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/changePasswordForm/manager/changePasswordManager.dart';
import 'package:foodorder/app/widgets/CustomTF/passwordTF.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';

class ChangePasswordForm extends StatelessWidget {
  ChangeManager manager;
  ChangePasswordForm(
      {required this.manager,
      required this.changePassAction,
      required this.onRefresh});
  Function() onRefresh;
  Function() changePassAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Center(
          child: Container(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            PasswordTF(
              password: true,
              controllr: manager.oldPassTF,
              topTitle: ConstantText.oldPassword,
              obscureText: manager.obscureText,
              errorMsg: manager.errorMsgOldPass,
              fontSize: 17,
              placeholder: ConstantText.passwordPlaceholder,
              onChange: (text) {},
              onChangeObsecure: (value) {
                manager.obscureText = value;
                onRefresh();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTF(
              password: true,
              controllr: manager.newPassTF,
              topTitle: ConstantText.newPassword.toUpperCase(),
              obscureText: manager.obscureTextNew,
              errorMsg: manager.errorMsgNewPass,
              fontSize: 17,
              placeholder: ConstantText.passwordPlaceholder,
              onChange: (text) {},
              onChangeObsecure: (value) {
                manager.obscureTextNew = value;
                onRefresh();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTF(
              password: true,
              controllr: manager.newPassConfTF,
              topTitle: ConstantText.confirmPassword.toUpperCase(),
              obscureText: manager.obscureTextNewConf,
              errorMsg: manager.errorMsgNewPassConf,
              fontSize: 17,
              placeholder: ConstantText.passwordPlaceholder,
              onChange: (text) {},
              onChangeObsecure: (value) {
                manager.obscureTextNewConf = value;
                onRefresh();
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomButton.regular(
                        width: double.infinity,
                        height: 50,
                        background: AppColor.redThemeColor,
                        title: ConstantText.update.toUpperCase(),
                        shadow: false,
                        borderWidth: 0,
                        fontSize: 16,
                        radius: 10,
                        fontweight: FontWeight.bold,
                        onTap: () {
                          changePassAction();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      )),
    );
  }
}
