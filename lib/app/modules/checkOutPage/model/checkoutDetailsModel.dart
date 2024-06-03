import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';

class CheckoutDetailModel {
  String id;
  String userId;
  String productId;
  String subcategoryId;
  String product_type;
  String quantity;
  bool loader = false;
  ProductsListModel products;

  CheckoutDetailModel(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.quantity,
      required this.product_type,
      required this.products,
      required this.subcategoryId,
      this.loader = false});

  factory CheckoutDetailModel.fromJson(Map<String, dynamic> json) {
    var products = ProductsListModel.fromJson(json['product']);
    return CheckoutDetailModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      productId: json['product_id'].toString(),
      quantity: json['quantity'].toString(),
      subcategoryId: json['subcategory_id'].toString(),
      products: products,
      product_type:json["product_type"].toString()
    );
  }
}
