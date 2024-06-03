import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/addAddressPage/view/addAddressPageView.dart';
import 'package:foodorder/app/modules/addressBookPage/components/bottomSheetUserAddress.dart';
import 'package:foodorder/app/modules/checkoutPage/component/checkoutProductList.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/productListPage/component/checkoutBottomSheet.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/services/getLocation/getLocation.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CheckoutScreenView extends StatefulWidget {
  CheckoutScreenView({super.key, required this.pageRefresh});

  Function() pageRefresh;

  @override
  State<CheckoutScreenView> createState() => _CheckoutScreenViewState();
}

class _CheckoutScreenViewState extends State<CheckoutScreenView> {
  var provider = GlobalVariable.productProviderManager;
  String paymentMethodValue = '-1';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCheckoutData();
      getlocation();
    });
  }

  getCheckoutData() async {
    await provider.getCheckoutProductsList(context: this);
    await provider.getCartRecord();
  }

  getlocation() async {
    provider.addressBookManager.selectedIndex = -1;
    provider.productManager.userPlaceOrderAddress = "";
    await LocationDetector().getLocation(onRefresh: () {
      provider.refresh();
    }, onSuccess: (fullAddress, latt, lngg) {
      provider.productManager.userPlaceOrderAddress = fullAddress;
      provider.productManager.latitude = latt.toString();
      provider.productManager.longitude = lngg.toString();
    });
    provider.refresh();
  }

  @override
  Widget build(BuildContext context) {
    print('isloader ${provider.checkoutManager.isLoader}');
    return Consumer<ProductProvider>(builder: (context, object, child) {
      print('testarrr${provider.productManager.userPlaceOrderAddress}');
      return Scaffold(
        bottomSheet: provider.checkoutManager.isLoader
            ? Container()
            : provider.checkoutManager.checkoutDetailData.length > 0
                ? CheckoutBottomSheet(
                    cartCalculationModel: provider.productManager.cartItemModel,
                    productProvider: provider,
                    isCheckoutPage: true,
                    callBack: () {
                      if (paymentMethodValue == '-1') {
                        showAlert('Please select payment mode');
                      } else {
                        print("vvvvvvv");
                        provider.placeOrder(
                            context: context,
                            paymentmode: paymentMethodValue,
                            onSuccess: () {
                              placeDialog();
                            });
                      }
                    },
                    btnName: 'Place Order')
                : Text(""),
        appBar: CustomHomeIconAppBar(
            title: ConstantText.checkoutTitle,
            backBtnAction: () {
              widget.pageRefresh();
            }),
        body: (provider.checkoutManager.checkoutDetailData.isNotEmpty)
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        itemCount:
                            provider.checkoutManager.checkoutDetailData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext, index) {
                          var item = provider.checkoutManager
                              .checkoutDetailData[index].products;
                          return CheckoutProductList(
                              productProvider: provider,
                              checkoutProductData: item);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(2),
                            child: Divider(
                              color: AppColor.dividerColor,
                            ),
                          );
                        },
                      ),

                      Divider(
                        color: AppColor.dividerColor,
                      ),

                      //calculation start
                      provider.productManager.cartDetailLoader
                          ? Container(
                              height: 100,
                              child: loaderListWithoutPadding(),
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ConstantText.totalItem),
                                    // Spacer(),
                                    Text(
                                        "₹${provider.productManager.cartItemModel?.subTotal}")
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(ConstantText.deliveryCharges),
                                    // Spacer(),
                                    Text(
                                        "₹${provider.productManager.cartItemModel?.deliveryCharges}")
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ConstantText.grandtotal,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    // Spacer(),
                                    Text(
                                      "₹${provider.productManager.cartItemModel?.grandTotal}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                      //calculation end

                      Divider(
                        color: AppColor.dividerColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //address column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ConstantText.deliveringTo.toUpperCase()

                                // provider.productManager.userPlaceOrderAddressType
                                //     .toUpperCase()
                                ,
                                style: const TextStyle(
                                    color: Color.fromRGBO(154, 154, 154, 1),
                                    fontWeight: FontWeight.w400),
                              ),
                              // const Spacer(),
                              ChangeBtnView(
                                  provider: provider, isChangeButton: true),
                            ],
                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              '${provider.productManager.userPlaceOrderAddress}',
                              style: TextStyle(
                                  color: Color.fromRGBO(57, 57, 57, 1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColor.dividerColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'PAYMENT MODE',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    child: Radio(
                                      activeColor: AppColor.redThemeColor,
                                      value: 'cash',
                                      groupValue: paymentMethodValue,
                                      onChanged: (value) {
                                        setState(() {
                                          paymentMethodValue = 'cash';
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Cash",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              )),
                              // Expanded(
                              //     child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Container(
                              //       width: 20,
                              //       child: Radio(
                              //         activeColor: AppColor.redThemeColor,
                              //         value: 'online',
                              //         groupValue: paymentMethodValue,
                              //         onChanged: (value) {
                              //           setState(() {
                              //             paymentMethodValue = 'online';
                              //           });
                              //         },
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     const Text(
                              //       "Online",
                              //       style: TextStyle(fontSize: 15),
                              //     ),
                              //   ],
                              // )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/animations/runemptycart.json",
                      height: 200,
                      repeat: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Your shopping Cart is empty!'),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Routes.pushSimpleAndRemove(
                            context: GlobalVariable.getRootContext(),
                            child: HomeScreenView());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.redThemeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20)),
                      child: Text(
                        'Continue Shopping',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  placeDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.white,
              content: Lottie.asset(
                "assets/animations/placeOrder.json",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    provider.checkoutManager.checkoutDetailData = [];
                    provider.productManager.cartItemModel = null;
                    Routes.pushSimpleAndRemove(
                        context: GlobalVariable.getRootContext(),
                        child: HomeScreenView());
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: AppColor.redThemeColor),
                  ),
                )
              ],
            ),
          );
        });
  }
}

_navigateToAddAddressPageView(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddAddressPageView()),
  );
}
