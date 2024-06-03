import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/checkoutPage/component/productAttributeList.dart';
import 'package:foodorder/app/modules/orderHistoryPage/model/orderHistoryListModel.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';

class OrderDetailsView extends StatelessWidget {
  OrderDetailsView({required this.orderDetailData});
  OrderHistoryListModel orderDetailData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(title: ConstantText.orderDetailsPageHeading),
      body: OrderSummaryDetails(),
    );
  }

  OrderSummaryDetails() {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 8,
        bottom: 8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: orderDetailData.status == 'pending'
                    ? AppColor.darkOrangeGreen
                    : AppColor.seaGreen,
              ),
              height: 30,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    orderDetailData.orderStatusMsg,
                    style: TextStyle(
                      color: orderDetailData.status == 'pending'
                          ? AppColor.orangeGreen
                          : AppColor.darkShadeSeaGreen,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstantText.orderItems,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const SizedBox(
              height: 12,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderDetailData.orderDetails.length,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext, index) {
                var singleItemPrice = orderDetailData
                            .orderDetails[index].product.salePrice !=
                        '0'
                    ? double.parse(
                        orderDetailData.orderDetails[index].product.salePrice)
                    : double.parse(orderDetailData
                        .orderDetails[index].product.regularPrice);
                var orderedQuantity =
                    int.parse(orderDetailData.orderDetails[index].quantity);

                var finalProductPrice = (singleItemPrice * orderedQuantity);

                print('check ${orderDetailData.orderDetails[index].id}');
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            orderDetailData.orderDetails[index].product.name
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  orderDetailData.orderDetails[index].quantity
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  )),
                              Text(" x ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  )),
                              Text(
                                  "₹${orderDetailData.orderDetails[index].product.salePrice != '0' ? orderDetailData.orderDetails[index].product.salePrice : orderDetailData.orderDetails[index].product.regularPrice}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                          // Text(manager.orderDetailsList![index].item
                          //     .toString()),
                          Spacer(),
                          Text(
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              "₹$finalProductPrice")
                        ],
                      ),
                      ProductAttributeList(checkoutProductData: orderDetailData.orderDetails[index].product),
                      SizedBox(
                        height: 0,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppColor.dividerColor,
                );
              },
            ),
            // COde for the Ordered Food items List...

            Divider(
              color: AppColor.dividerColor,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ConstantText.totalItem,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "₹${orderDetailData.orderPricing?.subTotal}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(57, 57, 57, 1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ConstantText.tax,
                      style: TextStyle(
                          fontSize: 14, color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "₹0",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ConstantText.deliveryCharges,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "₹${orderDetailData.orderPricing?.deliveryCharges}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(57, 57, 57, 1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ConstantText.grandtotal,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "₹${orderDetailData.orderPricing?.grandTotal}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                )
              ],
            ),
            Divider(
              color: AppColor.dividerColor,
            ),

            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstantText.orderDetaislUpperCase,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                )),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ConstantText.orderID,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(57, 57, 57, 1)),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${orderDetailData.orderID}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(57, 57, 57, 1)),
                )),
            SizedBox(
              height: 20,
            ),

            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstantText.payment,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(120, 119, 119, 1)),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${capitalize(orderDetailData.paymentMode)}",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(57, 57, 57, 1)),
                )),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ConstantText.deliveryTo,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(57, 57, 57, 1)),
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${capitalize(orderDetailData.placedUserAddress)}",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(57, 57, 57, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
