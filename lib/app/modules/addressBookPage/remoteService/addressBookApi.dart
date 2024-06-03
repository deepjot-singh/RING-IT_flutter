import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/modules/addressBookPage/manager/addressBookManager.dart';
import 'package:foodorder/app/modules/addressBookPage/model/addressBookModel.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class AddressBookNetworkManager {
  AddressBookNetworkManager({
    required this.dataManager,
  });

  var api = HttpService();
  AddressBookManager dataManager;

  dataRepresent({onSuccess, onError, neeLoader = true}) async {
    // var internetCheckMsg = ConstantText.internetCheck;
    // if (await internetCheck() == false) {
    //   showAlert(
    //     internetCheckMsg,
    //   );
    //   return null;
    // }
    try {
      Map<dynamic, dynamic>? jsonResponse = await api.getService(
          url: ConstantUrls.wsGetAddress, isNeedFullScreenLoader: neeLoader);

      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            // showAlert(msg: errors["message"].toString());
          }
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["data"];
          if (data != null) {
            var list = data as List;
            List<AddressBookDataModel> dataList =
                list.map((e) => AddressBookDataModel.fromJson(e)).toList();
            if (dataManager.pageNo == 1) {
              dataManager.addressBook = [];
            }
            dataManager.addressBook.addAll(dataList);
          }
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              showAlert(errorMsg);
            }
          }
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      showAlert(
        ConstantText.msgSomethingWentWrong,
      );
      print(e);
    }
  }

  deleteUserAddressAPi(
      {onSuccess, onError, required userAddressId, required getData}) async {
    print("listttId-${userAddressId}");
    var deleteAddressUrl = ConstantUrls.wsDeleteAddress + userAddressId;
    Map<dynamic, dynamic>? jsonResponse =
        await api.getService(url: deleteAddressUrl);
    print(deleteAddressUrl);
    if (jsonResponse != null) {
      if (jsonResponse["status_code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422) {
        var error = jsonResponse["errors"];
        var isMessageKeyAvail = error.containsKey("message");
        if (isMessageKeyAvail) {
          // showAlert(msg: errors["message"].toString());
        }
        onError();
      } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
        showAlert(ConstantText.somethingWentWrong);
      } else if (jsonResponse["status"] == ResponseStatus.httpTrue) {
        String msg = jsonResponse["message"].toString();
        print("msg----$msg");
        showAlert(msg, onTap: () {
          getData();
          Navigator.of(GlobalVariable.getRootContext()).pop();
        });
        // AlertDialog(title: jsonResponse["message"], actions: <Widget>[
        //   Container(
        //     height: 35,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10),
        //         color: AppColor.redThemeClr),
        //     child: TextButton(
        //       child: Text(ConstantText.ok,
        //           style: TextStyle(color: Colors.white)),
        //       onPressed: () {
        //         Navigator.of(context).pop();p
        //       },
        //     ),
        //   ),
        // ]);
      } else {
        var isMessageKeyAvail = jsonResponse.containsKey("message");
        if (isMessageKeyAvail) {
          var errorMsg = jsonResponse["message"].toString();
          if (errorMsg != "") {
            showAlert(errorMsg);
          }
        }
        onError();
      }
    } else {
      onError();
    }
  }

  // setDefaultAddress({onSuccess, onError, userAddressId}) async {
  //   var finalUrl =
  //       ConstantUrls.wsSetDefaultAddress + '?address_id=' + userAddressId;
  //   Map<dynamic, dynamic>? jsonResponse =
  //       await api.getService(url: finalUrl, isNeedFullScreenLoader: false);
  //   print("useraddressssid $userAddressId");
  //   print('setDefaultAddress==== $jsonResponse');
  //   if (jsonResponse != null) {
  //     if (jsonResponse["status_code"] == ResponseStatus.http412 ||
  //         jsonResponse["status_code"] == ResponseStatus.http422) {
  //       print('first, ${jsonResponse['message']}');
  //       // var errors = jsonResponse["errors"];
  //       var isMessageKeyAvail = jsonResponse['message'];
  //       showAlert(isMessageKeyAvail);

  //       print('${isMessageKeyAvail}');
  //       if (isMessageKeyAvail) {
  //         print('here2');
  //         showAlert(isMessageKeyAvail);
  //       }
  //       onError();
  //     } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
  //       onSuccess();
  //     } else {
  //       var isMessageKeyAvail = jsonResponse.containsKey("message");
  //       if (isMessageKeyAvail) {
  //         var errorMsg = jsonResponse["message"].toString();
  //         if (errorMsg != "") {
  //           showAlert(errorMsg);
  //         }
  //       }
  //       onError();
  //     }
  //   } else {
  //     onError();
  //   }
  // }
}
