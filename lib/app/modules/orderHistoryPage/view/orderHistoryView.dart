import 'package:flutter/material.dart';
import 'package:foodorder/app/core/DateTimeFormat/dateTimeFormat.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/orderDetailsPage/view/orderDetailView.dart';
import 'package:foodorder/app/modules/orderHistoryPage/components/orderCardView.dart';
import 'package:foodorder/app/modules/orderHistoryPage/components/orderedProductList.dart';
import 'package:foodorder/app/modules/orderHistoryPage/manager/orderHistoryListManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  var manager = OrderHistoryListManager();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

// OrderDetailsView
  getData() async {
    await manager.getOrderHistoryListData(onRefresh: () {
      setState(() {});
    });
    print("Orders Data ${manager.orderHistoryList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(
        title: ConstantText.orderHistory,
        needBackIcon: false,
      ),
      backgroundColor: AppColor.dividerColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: manager.isLoading
                  ? loaderList()
                  : manager.orderHistoryList.isEmpty
                      ? noDataFound()
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: manager.orderHistoryList.length,
                          itemBuilder: ((context, index) {
                            print("ssss--${manager.orderHistoryList[index]}");
                            return OrderCardView(
                                orderHistoryData:
                                    manager.orderHistoryList[index]);
                          }),
                        ),
            )
          ],
        ),
      ),
    );
  }

  void onPressed() {}
}
