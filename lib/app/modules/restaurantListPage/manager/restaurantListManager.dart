import 'dart:convert';
import 'package:foodorder/app/modules/restaurantListPage/model/restaurantListModel.dart';

class RestaurantListManager {
  List<RestaurantListModel> restaurantList = [];
  dynamic response = [
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys",
      "speciality": "Chinese",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys2",
      "speciality": "Chinese",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys3 The Halal Guys3",
      "speciality": "Chinese & Veg",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys3",
      "speciality": "Chinese",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys3",
      "speciality": "Chinese",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys3",
      "speciality": "Chinese",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys3",
      "speciality": "Chinese",
      "rate": "400"
    },
    {
      "image": "assets/images/restaurant.png",
      "name": "The Halal Guys3",
      "speciality": "Chinese",
      "rate": "400"
    }
  ];

  getRestaurantListData() {
    var restaurantListData = response as List;
    if (restaurantListData.length >= 0) {
      restaurantList = restaurantListData
          .map((e) => RestaurantListModel.fromJson(e))
          .toList();
    }
  }
}
