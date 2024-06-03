import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/modules/deleteAccountPage/manager/deleteAccountManager.dart';

void showLogoutDialog() {
  showDialog(
      context: GlobalVariable.getRootContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            ConstantText.logOut,
          ),
          content: const Text(ConstantText.askLogOut,
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
                  manager.logOutAccount();
                  dismissWaitDialog();
                },
              ),
            ),
          ],
        );
      });
}
