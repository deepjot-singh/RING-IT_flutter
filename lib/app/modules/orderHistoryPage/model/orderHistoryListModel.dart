import 'package:foodorder/app/modules/productListPage/model/cartItemModel.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'dart:convert' as io;

class OrderHistoryListModel {
  String? id;
  String? orderID;
  String? date;
  String? order;
  String? price;
  String? status;
  String? userId;
  String? paymentMode;
  String? paymentStatus;
  String orderStatusMsg;
  String placedUserAddress;
  List<OrderDetailModel> orderDetails;
  CartItemModel? orderPricing;

  OrderHistoryListModel(
      {this.id,
      this.orderID,
      this.date,
      this.order,
      this.price,
      this.status,
      this.userId,
      this.paymentMode,
      this.paymentStatus,
      required this.orderStatusMsg,
      required this.orderDetails,
      required this.placedUserAddress,
      this.orderPricing});

  factory OrderHistoryListModel.fromJson(Map<String, dynamic> json) {
    print("hello");
    var list = json['order_details'] as List;
    List<OrderDetailModel> orderDetails =
        list.map((i) => OrderDetailModel.fromJson(i)).toList();
    var orderPriceDetail = CartItemModel.fromJson(json['order_pricing']);
    return OrderHistoryListModel(
      id: json['id'].toString(),
      orderID: json['order_id'].toString(),
      date: json['created_at'].toString(),
      order: json['total_items'].toString(),
      price: json['grand_total'].toString(),
      status: json['order_status'].toString(),
      userId: json['user_id'].toString(),
      paymentMode: json['payment_mode'].toString(),
      paymentStatus: json['payment_status'].toString(),
      orderStatusMsg: json['order_status_msg'].toString(),
      placedUserAddress: json['order_user_address'].toString(),
      orderDetails: orderDetails,
      orderPricing: orderPriceDetail,
    );
  }
}

class OrderDetailModel {
  String? id;
  String quantity;
  ProductsListModel product;

  OrderDetailModel({
    this.id,
    required this.quantity,
    required this.product,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    var productDetail = ProductsListModel.fromJson(json['product']);
    return OrderDetailModel(
      id: json['id'].toString(),
      quantity: json['quantity'].toString(),
      product: productDetail,
    );
  }
}
