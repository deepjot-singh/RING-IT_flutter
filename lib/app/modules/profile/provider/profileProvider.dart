import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/profile/manager/profileManager.dart';
import 'package:foodorder/app/modules/profile/remoteService/profileApi.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class ProfileProvider extends ChangeNotifier {
  var manager = ProfileManager();
  refresh() {
    GlobalVariable.ProfileProviderManager.notifyListeners();
  }

  clear() {
    manager.profileDataList = null;
    refresh();
  }

  profileDataRepresent({onSuccess, needLoader = true}) {
    ProfileApi(dataManager: manager).fetchprofileData(
        needLoader: needLoader,
        onSuccess: () {
          refresh();

          print("aaaaaa");
          print("**************");
          manager.isLoading = false;
          manager.name.text = capitalize(manager.profileDataList?.name) ?? "";
          manager.email.text =
              (manager.profileDataList?.email.toString() != 'null'
                  ? manager.profileDataList?.email
                  : "")!;

          manager.countryCode = manager.profileDataList?.country_code ?? "";
          manager.phone_number = manager.profileDataList?.phone_no ?? "";
          manager.phone_no.text = manager.countryCode + manager.phone_number;
          manager.selectedImage = manager.profileDataList?.imgsrc ?? "";
          GlobalVariable.addressProviderManager.refresh();
        },
        onError: () {
          refresh();
          manager.isLoading = false;
        });
    print("hhhhhhhh");
  }

  validation({required onRefresh, required context, required onSuccess}) {
    bool validationSuccess = true;
    if (manager.name.text.trim().isEmpty) {
      print("Name-${manager.name} is empty");

      return;
    }
    if (manager.email.text.trim().isEmpty) {
      print("Email-${manager.email}");
      showAlert(
        ConstantText.emailEmptyMsg,
      );
      return;
    }
    if (manager.phone_no.text.trim().isEmpty) {
      print("PhoneNumber-${manager.phone_no}");
      return;
    }
    if (validationSuccess) {
      print("ValidationSuccess");
      onRefresh();
      FocusManager.instance.primaryFocus?.unfocus();
      _updateApi(context: context, onSuccess: onSuccess);
    }
  }

  _updateApi({needLoader = true, context, required onSuccess}) {
    var apiManager = ProfileApi(dataManager: manager);
    apiManager.updateUserProfileData(
        onSuccess: () {
          onSuccess();
          GlobalVariable.addressProviderManager.refresh();
        },
        onError: () {
          GlobalVariable.addressProviderManager.refresh();
        },
        context: context);
  }
}
