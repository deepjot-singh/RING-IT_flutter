import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/addAddressPage/view/addAddressPageView.dart';
import 'package:foodorder/app/modules/addressBookPage/manager/addressBookManager.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:provider/provider.dart';

class ChangeBtnView extends StatefulWidget {
  var provider = GlobalVariable.productProviderManager;
  bool isChangeButton;
  ChangeBtnView(
      {super.key, required this.provider, this.isChangeButton = false});

  @override
  State<ChangeBtnView> createState() => _ChangeBtnViewState();
}

class _ChangeBtnViewState extends State<ChangeBtnView> {
  String? selectedValue;
  var manager = AddressBookManager();
  var provider = ProductProvider();

  @override
  void initState() {
    super.initState();
    provider = widget.provider;
    manager = provider.addressBookManager;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("object");
      getAddressDetails();
    });
  }

  getAddressDetails({neeLoader = true}) {
    manager.pageNo = 1;
    manager.getUserAddress(
        onRefresh: () {
          provider.refresh();
        },
        neeLoader: neeLoader);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Consumer<ProductProvider>(builder: (context, value, child) {
              return StatefulBuilder(builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          ConstantText.changeAddress.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddressPageView(
                                        isChangeButton: widget.isChangeButton,
                                        fromEditbtn: false,
                                        onSuccess: () {
                                          manager.pageNo = 1;
                                          print("hhhhhhhhhhhhhhhh");
                                          manager.getUserAddress(
                                              onRefresh: () {
                                                provider.refresh();
                                              },
                                              onSuccess: () {
                                                manager.selectedIndex = manager
                                                    .addressBook
                                                    .lastIndexOf(manager
                                                        .addressBook.last);
                                                provider
                                                    .getUserPlaceOrderAddress(
                                                        selectedAddress: manager
                                                            .addressBook.last,
                                                        needPop: false);
                                              },
                                              neeLoader: false);
                                        })));
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              //alignment: Alignment.center,
                              height: 29,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.redThemeColor,
                              ),
                              child: Center(
                                child: Text(
                                  ConstantText.addNewAddress,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            // height: 90,
                            child: Column(
                              //  mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // children: addressArry.map((addressArrys) {
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: manager.isLoading
                                      ? loaderList()
                                      : manager.addressBook.isEmpty
                                          ? noDataFound()
                                          : ListView.builder(
                                              itemCount:
                                                  manager.addressBook.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var address =
                                                    manager.addressBook[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Color(
                                                                0xffDADADA))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                child: Radio(
                                                                    activeColor:
                                                                        AppColor
                                                                            .redThemeColor,
                                                                    value:
                                                                        index,
                                                                    groupValue:
                                                                        manager
                                                                            .selectedIndex, // Update this with selected index
                                                                    onChanged:
                                                                        (value) {
                                                                      manager.selectedIndex =
                                                                          value!;
                                                                      setState(
                                                                          () {});
                                                                      print(
                                                                          'valuevaluevalue $value   $index');
                                                                      provider
                                                                          .getUserPlaceOrderAddress(
                                                                        selectedAddress:
                                                                            manager.addressBook[index],
                                                                      );
                                                                    }),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 10,
                                                              bottom: 10,
                                                              right: 10,
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${address.houseNumber}, ${capitalize(address.locality)},${address.landmark != 'null' ? address.landmark : ""}, ${address.pincode}',
                                                                  // manager.dataList![index].data!.id,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                Text(
                                                                  address.countryCode
                                                                              .toString() !=
                                                                          ""
                                                                      ? '${address.countryCode} ${address.phoneNumber}'
                                                                      : address
                                                                          .phoneNumber
                                                                          .toString(),
                                                                  // manager.dataList![index].data!.id,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                ),
                                // })
                              ].toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            });
          },
        );
      },
      child: Text(
        ConstantText.change,
        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w700),
      ),
    );
  }
}
