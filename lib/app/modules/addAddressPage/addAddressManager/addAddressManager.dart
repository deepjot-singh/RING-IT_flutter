import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressProvider/addAddressProvider.dart';

class AddAddressManager {
  // var provider = GlobalVariable.addressProviderManager;
  // String? code = "+91";
  final List<String> items = ['home', 'office', 'hotel', 'other'];
  String? selectedValue;
  var code = "+91";
  TextEditingController nameTF = TextEditingController();
  TextEditingController phoneTF = TextEditingController();
  TextEditingController houseNoTF = TextEditingController();
  TextEditingController localityTF = TextEditingController();
  TextEditingController addressTypeTF = TextEditingController();
  TextEditingController landmarkTF = TextEditingController();
  TextEditingController pincodeTF = TextEditingController();
  TextEditingController latTF = TextEditingController();
  TextEditingController lngTF = TextEditingController();
  TextEditingController countryCodeTf = TextEditingController();
  String fullAddress = "";
  String nameError = "";
  String phoneError = "";
  String houseNoError = "";
  String localityError = "";
  String addressType = "";
  String pinError = "";
  clear() {
    nameError = "";
    phoneError = "";
    houseNoError = "";
    localityError = "";
    // addressType = "";
    pinError = "";
  }

  void _gotoAddAdress() {
    print("llllll11${nameTF.text}");
    GlobalVariable.addressProviderManager.validation();
  }
}
