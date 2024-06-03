import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressManager/addAddressManager.dart';
import 'package:foodorder/app/modules/addAddressPage/remoteService/remoteService.dart';
import 'package:foodorder/app/modules/addressBookPage/manager/addressBookManager.dart';
import 'package:foodorder/app/modules/addressBookPage/model/addressBookModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:provider/provider.dart';

class AddressProvider extends ChangeNotifier {
  var manager = AddAddressManager();
  var managerBook = AddressBookManager();

  validation(
      {onRefresh,
      onSuccess,
      isChangeButton = false,
      AddressBookDataModel? addressData,
      String? addressId,
      context}) {
    bool isvalid = true;
    print("prrrrrr- ${addressData?.name}");
    print("prrrrrr- ${addressId}");
    print("prrrrrr- ${manager.nameTF.text}");
    if (manager.nameTF.text.trim().isEmpty) {
      print("llllll1");

      manager.nameError = ConstantText.Required;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.phoneTF.text.trim().isEmpty) {
      print("llllll2");
      manager.phoneError = ConstantText.Required;
      onRefresh();
      //   GlobalVariable.addressProviderManager.refresh();
      //GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.phoneTF.text.isNotEmpty && manager.phoneTF.text.length != 10) {
      print("llllll2");
      manager.phoneError = ConstantText.phoneNumberMustContain10Digits;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      //GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.houseNoTF.text.trim().isEmpty) {
      print("llllll3");
      manager.houseNoError = ConstantText.Required;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.countryCodeTf.text.trim().isEmpty) {
      print("llllll35");
      manager.countryCodeTf.text = manager.code;
      onRefresh();
      // manager.houseNoError = ConstantText.Required;
      // GlobalVariable.addressProviderManager.refresh();
      // isvalid = false;
    }
    if (manager.localityTF.text.trim().isEmpty) {
      print("llllll4");
      manager.localityError = ConstantText.Required;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.pincodeTF.text.trim().isEmpty) {
      print("llllll5");
      manager.pinError = ConstantText.Required;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.latTF.text.trim().isEmpty) {
      print("llllll6");
      manager.pinError = ConstantText.Required;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.lngTF.text.trim().isEmpty) {
      print("llllll7");
      manager.pinError = ConstantText.Required;
      onRefresh();
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    if (manager.addressTypeTF.text.isEmpty) {
      print("llllll8");
      showAlert("please select one address type");
      onRefresh();
      // manager.pinError = ConstantText.Required;
      // GlobalVariable.addressProviderManager.refresh();
      isvalid = false;
    }
    // if (manager.addressTypeTF.text.trim().isEmpty) {
    //   print("llllll9");

    //   manager.pinError = ConstantText.Required;

    //   GlobalVariable.addressProviderManager.refresh();

    //   isvalid = false;
    // }
    if (isvalid == true) {
      print("llllll10");
      FocusManager.instance.primaryFocus?.unfocus();
      if (addressId != null) {
        print("UpdateRemoteService");
        _updateRemoteService(needloader: true, id: addressId);
      } else {
        print("REmoteService");
        _remoteService(
            context: context,
            onSuccess: () {
              if (onSuccess != null) {
                onSuccess();
              }
            },
            isChangeButton: isChangeButton);
      }
    }
  }

  refresh() {
    GlobalVariable.addressProviderManager.notifyListeners();
  }

  void _remoteService(
      {needloader = true, required context, onSuccess, isChangeButton}) {
    print("AddressTrype--${manager.addressTypeTF.text}");
    var apiManager = AddressApiService(dataManager: manager);
    apiManager.addAddress(
        isChangeButton: isChangeButton,
        context: context,
        onSuccess: () {
          print("obbbbbb");
          if (onSuccess != null) {
            onSuccess();
          }
          managerBook.getUserAddress(
              onRefresh: () {
                refresh();
              },
              neeLoader: false);
          refresh();
        },
        onError: () {
          refresh();
        },
        needLoader: needloader);
  }

  void _updateRemoteService({needloader = true, required id}) {
    print("hhhhhh${manager.addressTypeTF.text}");
    var apiManager = AddressApiService(dataManager: manager);
    apiManager.updateAddress(
        id: id,
        onSuccess: () {
          managerBook.getUserAddress(
              onRefresh: () {
                refresh();
              },
              neeLoader: false);
          refresh();
        },
        onError: () {
          refresh();
        },
        needLoader: needloader);
  }
}
