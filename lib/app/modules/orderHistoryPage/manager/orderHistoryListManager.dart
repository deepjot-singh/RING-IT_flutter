import 'package:foodorder/app/modules/orderHistoryPage/model/orderHistoryListModel.dart';
import 'package:foodorder/app/modules/orderHistoryPage/remoteService/orderHistoryApi.dart';

class OrderHistoryListManager {
  List<OrderHistoryListModel> orderHistoryList = [];
  var isLoading = true;

  getOrderHistoryListData({onRefresh}) async {
    isLoading = true;
    onRefresh();
    await orderHistoryApi(orderHistoryManager: this).orderHistoryData(
        onSuccess: () {
      print("successorderrrrr ${orderHistoryList.length}");
      isLoading = false;
      onRefresh();
    }, onError: () {
      isLoading = false;
    });

    // dynamic response = [
    //   {
    //     "orderID": "#123454321",
    //     "date": "29 Jan 2024 at 01:30 AM",
    //     "order": "1 x Pizza farmhouse",
    //     "price": "Rs 400",
    //     "status": "Delivered"
    //   },
    //   {
    //     "orderID": "#123454321",
    //     "date": "29 Jan 2024 at 01:30 AM",
    //     "order": "1 x Pizza farmhouse",
    //     "price": "Rs 400",
    //     "status": "Cancelled"
    //   },
    //   {
    //     "orderID": "#123454321",
    //     "date": "29 Jan 2024 at 01:30 AM",
    //     "order": "1 x Pizza farmhouse",
    //     "price": "Rs 400",
    //     "status": "Delivered"
    //   },
    // ];
  }
}
