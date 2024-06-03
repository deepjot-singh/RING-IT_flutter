import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/orderHistoryPage/model/orderHistoryListModel.dart';

class OrderProductList extends StatelessWidget {
  OrderProductList(
      {super.key, required this.orderProductData, required this.showMore});
  OrderDetailModel orderProductData;
  bool showMore;
  dynamic token;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 12),
            //   child: Image.asset(
            //     "assets/icons/vector.png",
            //     height: 12,
            //   ),
            // ),
            Text(
              '${orderProductData.quantity} x',
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.lightGrey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                orderProductData.product.name.toString(),
                style: TextStyle(
                    color: AppColor.lightGrey,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        showMore ? Text('see more...') : Container()
      ],
    );
  }
}
