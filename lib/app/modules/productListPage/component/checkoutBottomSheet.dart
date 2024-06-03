import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/checkoutPage/view/checkoutPageView.dart';
import 'package:foodorder/app/modules/productListPage/manager/productListManager.dart';
import 'package:foodorder/app/modules/productListPage/model/cartItemModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CheckoutBottomSheet extends StatelessWidget {
  CheckoutBottomSheet(
      {super.key,
      required this.cartCalculationModel,
      required this.productProvider,
      this.callBack,
      this.btnName = 'Place Order',
      this.isCheckoutPage = false});
  CartItemModel? cartCalculationModel;
  ProductProvider productProvider;
  Function? callBack;
  String btnName = 'Place Order';
  bool isCheckoutPage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 90,
      child: productProvider.productManager.cartDetailLoader
          ? loaderListWithoutPadding()
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${cartCalculationModel?.totalItems} ITEMS",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        isCheckoutPage
                            ? "₹${cartCalculationModel?.grandTotal}"
                            : "₹${cartCalculationModel?.subTotal}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      callBack!();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.redThemeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20)),
                    child: Text(
                      btnName,
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
  }
}
