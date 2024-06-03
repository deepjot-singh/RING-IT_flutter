class CartItemModel {
  String totalItems;
  String? subTotal;
  String? deliveryCharges;
  String? grandTotal;

  CartItemModel({
    required this.totalItems,
    required this.subTotal,
    required this.deliveryCharges,
    required this.grandTotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      totalItems: json['total_items'].toString().toString() != "null"
          ? json['total_items'].toString().toString()
          : "",
      subTotal: json['sub_total'].toString().toString() != "null"
          ? json['sub_total'].toString().toString()
          : "",
      deliveryCharges: json['delivery_charges'].toString(),
      grandTotal: json['grand_total'].toString(),
    );
  }
}
