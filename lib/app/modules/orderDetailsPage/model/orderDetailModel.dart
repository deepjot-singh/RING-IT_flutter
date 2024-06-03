

class OrderDetailsModel {
  String item;
  String price;
  String quantity;

  OrderDetailsModel(
      {required this.item, required this.price, required this.quantity});

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
        item: json['item'].toString(),
        price: json['price'].toString(),
        quantity: json['quantity'].toString()

        // foodtypes: FoodTypes.fromJson(json["food_type"]),
        );
  }
}
