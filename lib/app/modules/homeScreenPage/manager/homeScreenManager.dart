import 'package:flutter/material.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/homeScreenPage/remoteServices/homeScreenApi.dart';
import 'package:foodorder/app/modules/homeScreenPage/remoteServices/homeScreenSubcategoryListApi.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreenManager {
  List<HomeScreenCategoryModel> homeScreenList = [];
  List<ProductsListModel> homeScreenPopularList = [];

  RefreshController controller = RefreshController();
  var selectedIndex = -1;
  var isLoading = true;
  var isLoadingPopular = true;

  int pageNo = 1;
  final GlobalKey<ScaffoldState> key = GlobalKey();

  String adminContactNo = "";

  homeScreenDataRepresent({onRefresh}) {
    isLoading = true;
    onRefresh();
    var homeScreenDataRepresent =
        HomeScreenSubcategoryListApi(subcategoryManager: this);
    homeScreenDataRepresent.fetchSubcategoryData(onSuccess: () {
      isLoading = false;
      onRefresh();
    }, onError: () {
      isLoading = false;
      onRefresh();
    });
  }

  getPopularItems({onRefresh}) async {
    var userId = await LocalStore().getUserID();
    isLoadingPopular = true;
    onRefresh();
    var homeScreenDataRepresent =
        HomeScreenSubcategoryListApi(subcategoryManager: this);
    homeScreenDataRepresent.getPopularItemsApi(
        onSuccess: () {
          isLoadingPopular = false;
          onRefresh();
        },
        onError: () {
          isLoadingPopular = false;
          onRefresh();
        },
        userId: userId);
  }

  getAdminContact({onRefresh}) async {
    var homeScreenDataRepresent =
        HomeScreenSubcategoryListApi(subcategoryManager: this);
    homeScreenDataRepresent.getAdminContact(onSuccess: () {
      onRefresh();
    }, onError: () {
      onRefresh();
    });
  }
}
