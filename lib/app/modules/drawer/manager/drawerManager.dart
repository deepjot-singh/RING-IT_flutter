import 'package:flutter/material.dart';
import 'package:foodorder/app/modules/drawer/model/drawerModel.dart';

class DrawerManager {
  var userInfo = <DrawerModel>[];
  // UserPreference userPreference = UserPreference();
  DrawerManager() {
    userInfo.add(DrawerModel(
        imageName: Icons.storefront_outlined, labelText: 'Your Order', page: 'orders'));
    userInfo.add(DrawerModel(
        imageName: Icons.shopping_cart_outlined, labelText: 'Cart', page: 'cart'));
    print("--drawer length--${userInfo.length}");
  }

  removeShareData() {
    // userPreference.removeUser();
  }
}
