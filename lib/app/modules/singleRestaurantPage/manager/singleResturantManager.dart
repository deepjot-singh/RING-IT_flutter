import 'package:foodorder/app/modules/singleRestaurantPage/model/singleRestaurantModel.dart';

class SingleRestaurantManager {
  List<SingleRestaurantModel> restaurantDataList = [];
  dynamic response = [
    {"name": "Burger", 
    "food_type":"[{'type':'Classic Burger'},{'type':'Classic Burger'},{'type':'Classic Burger'}]"
    },

    {
      "name": "Pizza",
    },
    {
      "name": "Pasta",
    },
    {
      "name": "Wraps",
    },
    {
      "name": "Tandoori",
    },
    {
      "name": "Tandoori",
    },
    {
      "name": "Tandoori",
    },
    {
      "name": "Tandoori",
    },
    {
      "name": "Tandoori",
    },
    {
      "name": "Tandoori",
    },
  ];

  getSingleRestaurantData() {
    var singleRestaurantData = response as List;
    if (singleRestaurantData.length >= 0) {
      restaurantDataList = singleRestaurantData
          .map((e) => SingleRestaurantModel.fromJson(e))
          .toList();
    }
  }
}
