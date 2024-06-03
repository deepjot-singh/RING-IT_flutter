class SingleRestaurantModel {
  final String name;
  // FoodTypes foodtypes;

  SingleRestaurantModel({required this.name,
  // required this.foodtypes
  });

  factory SingleRestaurantModel.fromJson(Map<String, dynamic> json) {
    return SingleRestaurantModel(name: json['name'].toString(),

    // foodtypes: FoodTypes.fromJson(json["food_type"]),
    );
  }
}

// class FoodTypes {
//   final String type;
//   final String description;
//   final String price;

//   FoodTypes(
//       {required this.type, required this.description, required this.price});

//   factory FoodTypes.fromJson(Map<String, dynamic> json) {
//     return FoodTypes(
//       type: json['type'].toString(),
//       description: json['description'].toString(),
//       price: json['price'].toString(),
//     );
//   }
// }
