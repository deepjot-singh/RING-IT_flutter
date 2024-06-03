// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:foodorder/app/modules/profile/model/profileModel.dart';
import 'package:foodorder/app/modules/profile/remoteService/profileApi.dart';
import 'package:foodorder/app/modules/profile/remoteService/profileApi.dart';
import 'package:foodorder/app/modules/profile/remoteService/profileApi.dart';

class ProfileManager {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_no = TextEditingController();
  String countryCode = "";
  String phone_number = "";
  bool isChanged = false;
  ProfileModel? profileDataList;
  var imageSelector;
  String selectedImage = "";

  var isLoading = true;
  var changeImage = false;

  // profileDataRepresent({onRefresh}) async {
  //   await ProfileApi(manager: this).fetchprofileData(onSuccess: () {
  //     isLoading = false;
  //     name.text = profileDataList?.name ?? "";
  //     email.text = profileDataList?.email ?? "";

  //     countryCode = profileDataList?.country_code ?? "";
  //     phone_number = profileDataList?.phone_no ?? "";
  //     phone_no.text = countryCode + phone_number;
  //     onRefresh();
  //   }, onError: () {
  //     isLoading = false;
  //   });
  // }

  // validation({required onRefresh, required context}) {
  //   bool validationSuccess = true;
  //   if (name.text.trim().isEmpty) {
  //     print("Name-$name");
  //     return;
  //   }
  //   if (email.text.trim().isEmpty) {
  //     print("Email-$email");
  //     return;
  //   }
  //   if (phone_no.text.trim().isEmpty) {
  //     print("PhoneNumber-$phone_no");
  //     return;
  //   }
  //   if (validationSuccess) {
  //     print("ValidationSuccess");
  //     onRefresh();
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     _updateApi(onRefresh: onRefresh, context: context);
  //   }
  // }

  // _updateApi({required onRefresh, needLoader = true, context}) {
  //   var apiManager = ProfileApi(manager: this);
  //   apiManager.updateUserProfileData(
  //       onSuccess: () {},
  //       onError: () {
  //         onRefresh();
  //       },
  //       context: context);
  // }
}
