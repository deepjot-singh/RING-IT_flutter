import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressManager/addAddressManager.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressProvider/addAddressProvider.dart';
import 'package:foodorder/app/modules/settingPage/view/settingView.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class AddressApiService {
  var apiService = HttpService();
  var error;
  AddAddressManager dataManager;
  AddressApiService({required this.dataManager});
  addAddress(
      {required onSuccess,
      required onError,
      required needLoader,
      isChangeButton = false,
      required context}) async {
    var internetCheckMsg = ConstantText.internetCheck;
    //  if (await internetCheck() == false) {
    //   showAlert(internetCheckMsg);
    //   return null;
    // }
    var url = ConstantUrls.wsAddAddress;
    try {
      var param = {
        "name": dataManager.nameTF.text,
        "phone_number": dataManager.phoneTF.text,
        "country_code": dataManager.countryCodeTf.text,
        "locality": dataManager.localityTF.text,
        "address_type": dataManager.addressTypeTF.text,
        "house_number": dataManager.houseNoTF.text,
        "landmark": dataManager.landmarkTF.text,
        "pincode": dataManager.pincodeTF.text,
        "latitude": dataManager.latTF.text,
        "longitude": dataManager.lngTF.text
      };

      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url);

      print('addAddress-- ${jsonResponse}');
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
          showAlert(msg, context: context, onTap: () {
            int count = 0;
            if (isChangeButton) {
              Navigator.popUntil(context, (route) {
                return count++ == 4;
              });
            } else {
              Navigator.popUntil(context, (route) {
                return count++ == 3;
              });
            }
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
      print(e);
  //    showAlert(ConstantText.somethingWentWrong);
    }
  }

  updateAddress(
      {required onSuccess,
      required onError,
      required needLoader,
      required id}) async {
    print("jjjjjj");
    var internetCheckMsg = ConstantText.internetCheck;
    //  if (await internetCheck() == false) {
    //   showAlert(internetCheckMsg);
    //   return null;
    // }
    var url = ConstantUrls.wsUpdateAddress;
    try {
      var param = {
        "address_id": id,
        "name": dataManager.nameTF.text,
        "phone_number": dataManager.phoneTF.text,
        "country_code": dataManager.countryCodeTf.text,
        "locality": dataManager.localityTF.text,
        "address_type": dataManager.addressTypeTF.text,
        "house_number": dataManager.houseNoTF.text,
        "landmark": dataManager.landmarkTF.text,
        "pincode": dataManager.pincodeTF.text,
        "latitude": dataManager.latTF.text,
        "longitude": dataManager.lngTF.text
      };

      Map<dynamic, dynamic>? jsonResponse =
          await apiService.postService(params: param, url: url);

      print('addAddress-- ${jsonResponse}');
      if (jsonResponse != null) {
        if (jsonResponse["status"] == ResponseStatus.http412 ||
            jsonResponse["status"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isEmailKeyAvail = errors.containsKey("email");
          var isPasswordKeyAvail = errors.containsKey("password");
          var isMessageKeyAvail = errors.containsKey("message");
        } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
          String msg = jsonResponse["message"].toString();
          showAlert(msg, DoublePopNeeded: true);
          onSuccess();
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
      print(e);
      showAlert(ConstantText.somethingWentWrong);
    }
  }
}
