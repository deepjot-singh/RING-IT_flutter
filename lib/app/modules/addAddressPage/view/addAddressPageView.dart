import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantKeys/constantKeys.dart';
import 'package:foodorder/app/core/locationFinder/locationFinder.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressManager/addAddressManager.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressProvider/addAddressProvider.dart';
import 'package:foodorder/app/modules/addressBookPage/model/addressBookModel.dart';
import 'package:foodorder/app/widgets/CustomTF/phoneTF.dart';
import 'package:foodorder/app/widgets/CustomTF/textfields/textFields.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';
import 'package:provider/provider.dart';
// import 'package:foodorder/app/modules/addAddressPage/';

class AddAddressPageView extends StatefulWidget {
  AddAddressPageView(
      {super.key,
      this.fromEditbtn = false,
      this.data,
      this.addressId,
      this.isChangeButton = false,
      this.confirmbtn,
      this.onSuccess,
      this.confirmAddress});
  bool? fromEditbtn;
  AddressBookDataModel? data;
  bool isChangeButton;
  String? addressId;
  Function()? onSuccess;
  bool? confirmbtn;

  Function(String)? confirmAddress;
  @override
  State<AddAddressPageView> createState() => _AddAddressPageViewState();
}

TextEditingController searchTf = TextEditingController();

class _AddAddressPageViewState extends State<AddAddressPageView> {
  var manager = AddAddressManager();
  var provider = AddressProvider();
  String updateAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = GlobalVariable.addressProviderManager;
    manager = provider.manager;
    print("LOCATION${widget.addressId}");
    print("LOCATION${widget.data}");
    //  if (widget.data != null && widget.addressId != null) {
    manager.nameTF.text = widget.data?.name ?? '';
    manager.phoneTF.text = widget.data?.phoneNumber ?? '';
    manager.houseNoTF.text = widget.data?.houseNumber ?? '';
    manager.localityTF.text = widget.data?.locality ?? '';
    manager.pincodeTF.text = widget.data?.pincode ?? '';
    manager.latTF.text = widget.data?.latitude ?? '';
    manager.lngTF.text = widget.data?.longitude ?? '';
    manager.landmarkTF.text = widget.data?.landmark ?? '';
    manager.addressTypeTF.text = widget.data?.addressType ?? '';
    manager.selectedValue = widget.data?.addressType ?? '';
    print("ADDRESS12 ${provider.manager.localityTF.text}");
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AddressProvider>(builder: (context, value, child) {
      return Container(
        color: Colors.black,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                  //height: MediaQuery.of(context).size.height * 0.82,
                  child: LocationFinderComponent(
                manager: manager,
                locationData: (setaddress) {
                  provider.manager.fullAddress = setaddress;
                  updateAddress = setaddress;
                  provider.refresh();
                  print("afff---${provider.manager.fullAddress}");
                },
              )),
            ),
            Container(
                // height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 15, left: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/location.png",
                            color: Colors.black,
                            height: 40,
                            width: 40,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8),
                              child: Text(
                                provider.manager.fullAddress,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (widget.confirmbtn == true)
                          ? CustomButton.regular(
                              height: 50,
                              shadow: false,
                              borderWidth: 0,
                              fontSize: 16,
                              radius: 10,
                              fontweight: FontWeight.bold,
                              onTap: () {
                                widget.confirmAddress!(updateAddress);
                                Navigator.of(context).pop();
                              },
                              background: AppColor.redThemeColor,
                              title: ConstantText.confirmOption,
                            )
                          : CustomButton.regular(
                              height: 50,
                              shadow: false,
                              borderWidth: 0,
                              fontSize: 16,
                              radius: 10,
                              fontweight: FontWeight.bold,
                              onTap: () {
                                if ((widget.addressId != null &&
                                        widget.addressId!.isNotEmpty) ||
                                    (provider.manager.latTF.text.isNotEmpty &&
                                        provider
                                            .manager.lngTF.text.isNotEmpty)) {
                                  print(
                                      "kkkk11${provider.manager.localityTF.text}");
                                  provider.manager.clear();
                                  addressForm(widget.addressId ?? "",
                                      provider.manager.code, widget.addressId);
                                } else {
                                  print("kkkk");
                                  showAlert(ConstantText.searchLocation);
                                }
                              },
                              background: AppColor.redThemeColor,
                              title: ConstantText.enterCompleteAddressButton
                                  .toUpperCase(),
                            ),
                    ],
                  ),
                )
                // SizedBox(
                //   height: 20,
                // ),

                )
          ],
        ),
      );
    }));
  }

  void addressForm(String id, String code, String? addressId) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            print("prrrrrr- ${addressId}");
            print("ADDRESS${provider.manager.localityTF.text}");
            final MediaQueryData mediaQueryData = MediaQuery.of(context);
            return Consumer<AddressProvider>(builder: (context, value, child) {
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: mediaQueryData.viewInsets,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            ConstantText.addressDetailsPageHeading,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Padding(padding: EdgeInsets.all(5));
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: manager.items.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      manager.selectedValue =
                                          manager.items[index];
                                      provider.manager.addressTypeTF.text =
                                          manager.items[index];
                                      //   provider.manager
                                      // .addressTypeTF =     manager.selectedValue ;
                                      // Here you can call your API with the selected value
                                      print(
                                          "Selected value: ${manager.selectedValue}");
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: (manager.selectedValue ==
                                                    manager.items[index])
                                                ? AppColor.redThemeColor
                                                : Colors.transparent),
                                        borderRadius: BorderRadius.circular(8),
                                        color: (manager.selectedValue ==
                                                manager.items[index])
                                            ? AppColor.pureWhite
                                            : Color.fromRGBO(227, 227, 227, 1)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(manager.items[index]
                                              .substring(0, 1)
                                              .toUpperCase() +
                                          manager.items[index].substring(1)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          (provider.manager.addressTypeTF.text.trim().isEmpty)
                              ? Container(
                                  child: Text(
                                    "please select one type",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldComponent(
                            errorMsg: provider.manager.nameError,

                            controllr: provider
                                .manager.nameTF, // ADD EMAIL CONTROLLER HERE
                            placeholder: ConstantText.name,
                            label: ConstantText.name,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ConstantText.phnNumber1,
                            style: TextStyle(
                                color: AppColor.blackstd,
                                fontWeight: FontWeight.w600),
                          ),

                          PhoneTFView(
                            noNeedTitle: true,
                            errorMsg: provider.manager.phoneError,
                            controller: provider.manager.phoneTF,
                            onTap: (value) {
                              code = value;
                              provider.manager.countryCodeTf.text = code;
                              print("countryCode-${code}");
                              print(
                                  "countryCode-${provider.manager.countryCodeTf.text}");
                              setState(() {});
                            }, // ADD PHONE CONTROLLER HER
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldComponent(
                            errorMsg: provider.manager.houseNoError,

                            controllr: provider
                                .manager.houseNoTF, // ADD EMAIL CONTROLLER HERE
                            placeholder: ConstantText.addressLine1Hint,
                            label: ConstantText.addressLine1Hint,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldComponent(
                            errorMsg: provider.manager.localityError,
                            height: 90,
                            maxlines: 10,

                            controllr: provider.manager
                                .localityTF, // ADD EMAIL CONTROLLER HERE
                            placeholder: ConstantText.addressLine2Hint,
                            label: ConstantText.addressLine2Hint,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldComponent(
                            errorMsg: provider.manager.pinError,
                            keyBoardType: TextInputType.number,
                            neededInputFormat: true,
                            controllr: provider.manager
                                .pincodeTF, // ADD pincode CONTROLLER HERE
                            placeholder: ConstantText.pincode,
                            label: ConstantText.pincode,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldComponent(
                            controllr: provider.manager
                                .landmarkTF, // ADD EMAIL CONTROLLER HERE
                            placeholder: ConstantText.addressNearbyHint,
                            label: ConstantText.addressNearbyHint,
                            onChange: (text) {
                              setState(() {});
                            },
                          ),

                          // SizedBox(
                          //   height: 20,
                          // ),
                          // TextFieldComponent(
                          //   controllr: provider.manager
                          //       .addressTypeTF, // ADD EMAIL CONTROLLER HERE
                          //   placeholder: ConstantText.addressTypeHint,
                          // ),

                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print("jjjjjjjkkkkkk");
                                provider.validation(
                                    isChangeButton: widget.isChangeButton,
                                    onRefresh: () {
                                      setState(() {});
                                    },
                                    onSuccess: () {
                                      if (widget.onSuccess != null) {
                                        widget.onSuccess!();
                                      }
                                    },
                                    addressId: addressId,
                                    context: context);

                                //  Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.redThemeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15)),
                              child: Text(
                                ConstantText.saveAddress.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          });
        });
  }

  addressTypeDropdown(String dropdownValue) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.textFeildBdr
              //color: AppColor.textBlackColor
              //                   <--- border width here
              ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            //  hint: Padding(
            //     padding: const EdgeInsets.only(left: 15),
            //     child: new Text(
            //       "Select Time",
            //       style: TextStyle(
            //         fontSize: 15,
            //         color:AppColor.textFeildBdr
            //       ),
            //     ),
            //   ),
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                provider.manager.addressTypeTF.text =
                    dropdownValue; // ADD EMAIL CONTROLLER HERE
              });
            },
            items: <String>['home', 'office', 'hotel', 'other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value.substring(0, 1).toUpperCase() + value.substring(1),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
