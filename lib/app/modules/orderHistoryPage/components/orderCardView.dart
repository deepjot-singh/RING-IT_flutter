import 'package:flutter/material.dart';
import 'package:foodorder/app/core/DateTimeFormat/dateTimeFormat.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/orderDetailsPage/view/orderDetailView.dart';
import 'package:foodorder/app/modules/orderHistoryPage/components/orderedProductList.dart';
import 'package:foodorder/app/modules/orderHistoryPage/model/orderHistoryListModel.dart';

class OrderCardView extends StatelessWidget {
  OrderCardView({super.key, required this.orderHistoryData});
  OrderHistoryListModel orderHistoryData;
  dynamic token;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffDADADA), width: 1),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color.fromARGB(255, 233, 233, 233),
          //     offset: Offset(
          //       1.0,
          //       1.0,
          //     ),
          //     blurRadius: 2.0,
          //     spreadRadius: 2.0,
          //   ), //BoxShadow
          //   BoxShadow(
          //     color: Colors.white,
          //     offset: Offset(0.0, 0.0),
          //     blurRadius: 0.0,
          //     spreadRadius: 0.0,
          //   ), //BoxShadow
          // ],
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrderDetailsView(orderDetailData: orderHistoryData),
              ),
            );
          },
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${orderHistoryData.orderID.toString()}',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            color: orderHistoryData.status == 'delivered'
                                ? Color.fromRGBO(210, 210, 210, 1)
                                : Color.fromRGBO(242, 168, 168, 1)),
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Text(
                            orderHistoryData.status!.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                color: orderHistoryData.status == 'delivered'
                                    ? Color.fromRGBO(57, 57, 57, 1)
                                    : Color.fromRGBO(221, 94, 94, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    getDateFormat(orderHistoryData.date.toString()),
                    style: TextStyle(
                        color: AppColor.lightGrey, fontWeight: FontWeight.w700),
                  ),
                ),
                Divider(
                  color: AppColor.dividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        maxHeight: 1000), // **THIS is the important part**
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderHistoryData.orderDetails.length <= 2
                          ? orderHistoryData.orderDetails.length
                          : 2,
                      itemBuilder: (BuildContext context, int orderIndex) {
                        //ordered product list
                        return OrderProductList(
                            // show see more only if ordered products are more that 2
                            showMore:
                                (orderHistoryData.orderDetails.length > 2 &&
                                        orderIndex == 1)
                                    ? true
                                    : false,
                            orderProductData:
                                orderHistoryData.orderDetails[orderIndex]);
                      },
                    ),
                  ),
                ),
                Divider(
                  color: AppColor.dividerColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 7, bottom: 7, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      orderHistoryData.status == 'complete'
                          ? SizedBox(
                              width: 90,
                              height: 35,
                              child: FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: AppColor.redThemeColor,
                                child: const Text(
                                  ConstantText.reorder,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          : Container(),
                      Row(
                        children: [
                          Text(
                            "₹${orderHistoryData.price.toString()}",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColor.lightGrey,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
