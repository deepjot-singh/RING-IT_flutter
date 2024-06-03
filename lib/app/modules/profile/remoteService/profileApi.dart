import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/profile/manager/profileManager.dart';
import 'package:foodorder/app/modules/profile/model/profileModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class ProfileApi {
  var api = HttpService();
  ProfileManager dataManager = ProfileManager();
  ProfileApi({required this.dataManager});

  fetchprofileData({onSuccess, onError, needLoader = true}) async {
    try {
      Map<dynamic, dynamic>? jsonResponse = await api.getService(
          isNeedFullScreenLoader: needLoader, url: ConstantUrls.wsProfile);
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse['status_code'] == ResponseStatus.http422) {
          var errors = jsonResponse['errors'];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            //showAlert
          }
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse['data'];
          var name = data['name'];

          print("ProfileData --$data");
          if (data != null) {
            dataManager.profileDataList =
                ProfileModel.fromJson(jsonResponse['data']);
            ProfileModel.currentUser = dataManager.profileDataList;
            onSuccess();
            // return dataManager.profileDataList;
          }
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              //show alert
            }
          }
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      ConstantText.somethingWentWrong;
    }
  }

  updateUserProfileData(
      {required onSuccess, required onError, required context}) async {
    print("hvhjbkjbkj");
    // var internetCheckMsg = ConstantText.internetCheck;
    // if (await internetCheck() == false) {
    //   showAlert(internetCheckMsg);
    //   return null;
    // }
    try {
      var url = ConstantUrls.wsUpdateProfile;
      var token = LocalStore().getToken().toString();
      var header = {
        "Authorization": token,
      };

      var request = MultipartRequest("POST", Uri.parse(url));

      request.fields['name'] = dataManager.name.text;
      request.fields['email'] = dataManager.email.text;
      // request.fields['image'] = dataManager.imageSelector.toString();
      print("filename----${dataManager.imageSelector}");
      print("changeImage${dataManager.changeImage}");
      if (dataManager.changeImage == true) {
        if (dataManager.imageSelector != "") {
          File file = dataManager.imageSelector;

          print("ValidationSuccess2- ${file}");
          var fileName = file.path.split('/').last;

          print("fileName-${fileName}");
          request.files.add(MultipartFile(
            'image',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: fileName,
          ));
        }
      }

      print(request.fields);
      Map<dynamic, dynamic>? jsonResponse = await api.postPartsService(
          request: request, isNeedFullScreenLoader: false);
      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isEmailKeyAvail = errors.containsKey("email");
          var isPasswordKeyAvail = errors.containsKey("password");
          var isMessageKeyAvail = errors.containsKey("message");
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          String msg = jsonResponse["message"].toString();
          showAlert(msg, onTap: () {
            Navigator.of(GlobalVariable.getRootContext()).pop();
          });
          onSuccess();

          // showAlertWithConfirmButton(
          //   msg: jsonResponse["message"].toString(),
          //   onTap: () {},
          // );
        } else if (jsonResponse["status"] == ResponseStatus.http418) {
          showAlertWithConfirmButton(
            msg: jsonResponse["message"].toString(),
            onTap: () {},
          );
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              showAlert(errorMsg);
            }
          }
        }
      }
    } catch (e) {
      //  showAlert(ConstantText.somethingWentWrong);
    }
  }
}
