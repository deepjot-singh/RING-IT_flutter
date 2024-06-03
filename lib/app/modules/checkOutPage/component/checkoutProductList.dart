import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/checkoutPage/component/productAttributeList.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/widgets/dottedLine/dottedLine.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class CheckoutProductList extends StatelessWidget {
  CheckoutProductList(
      {super.key,
      required this.checkoutProductData,
      required this.productProvider});
  ProductsListModel checkoutProductData;
  ProductProvider productProvider;
  dynamic token;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      capitalize(checkoutProductData.name.toString()),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    checkoutProductData.salePrice != '0'
                        ? "₹${checkoutProductData.salePrice.toString()}"
                        : "₹${checkoutProductData.regularPrice.toString()}",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ],
              ),
              // Spacer(),
              Card(
                  color: AppColor.redThemeColor,
                  child: SizedBox(
                      height: 40,
                      width: 106,
                      child: checkoutProductData.quantity == 0
                          ? TextButton(
                              child: const Text(
                                ConstantText.addItemCheckout,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {},
                            )
                          : Container(
                              height: 30,
                              width: 20,
                              child: checkoutProductData.loader
                                  ? loaderListWithoutPadding(
                                      color: Colors.white)
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: AppColor.pureWhite,
                                          ),
                                          onPressed: () {
                                            productProvider
                                                .removeFromCartProduct(
                                                    productData:
                                                        checkoutProductData,
                                                    isCheckoutPage: true);
                                          },
                                        ),
                                        Text(
                                          checkoutProductData.quantity
                                              .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: AppColor.pureWhite,
                                          ),
                                          onPressed: () {
                                            productProvider.addToCartProduct(
                                                productData:
                                                    checkoutProductData,
                                                isCheckoutPage: true);
                                          },
                                        ),
                                      ],
                                    ),
                            )
                      // IncrementDecrementBtnChkOut(
                      //     quantity: quantity,
                      //   ),
                      ))
            ],
          ),
          ProductAttributeList(checkoutProductData: checkoutProductData)
        ],
      ),
    );
  }
}
