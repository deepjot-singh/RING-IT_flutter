import 'dart:convert';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenSubcategoryListComponentManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';

import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class HomeScreenSubcategoryListApi {
  var api = HttpService();
  HomeScreenManager subcategoryManager;
  HomeScreenSubcategoryListApi({required this.subcategoryManager});

  fetchSubcategoryData({onSuccess, onError}) async {
    try {
      var url = ConstantUrls.wsHomeScreenSubcategory;
      Map<dynamic, dynamic>? jsonResponse =
          await api.getService(url: url, isNeedFullScreenLoader: false);
      print("URL---$url");
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {}
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          print("Response--$jsonResponse");
          showAlert(ConstantText.somethingWentWrong);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          print('success=====');
          var list = jsonResponse["data"] as List;
          if (list.isNotEmpty) {
            subcategoryManager.homeScreenList =
                list.map((e) => HomeScreenCategoryModel.fromJson(e)).toList();
            print(
                " subcategoryManager.homeScreenList---${subcategoryManager.homeScreenList}");
          }
          print("Subcategorydata---$list");
          onSuccess();

          // var data = print("hiiiiii");
          // list.map((e) => HomeScreenCategoryModel.fromJson(e)).toList();
          // return onSuccess(data);
        }
      }
      // var list = jsonResponse!["data"]["subcategories"] as List;
      // print("SUBSUB---$list");
      // var data = list.map((e) => HomeScreenCategoryModel.fromJson(e)).toList();
      // return onSuccess(data);
    } catch (e) {
      // showAlert(ConstantText.somethingWentWrong);
    }
  }

  getPopularItemsApi(
      {required onSuccess, required onError, required userId}) async {
    var param;
    if (userId.toString().isNotEmpty) {
      param = {"user_id": userId.toString()};
    } else {
      param = "";
    }
    Map<dynamic, dynamic>? jsonResponse = await api.postService(
        url: ConstantUrls.wsPopularItems,
        isNeedFullScreenLoader: false,
        params: param);
    if (jsonResponse != null) {
      if (jsonResponse["status_code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422) {
        onError();
      } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
        showAlert(ConstantText.somethingWentWrong);
        onError();
      } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
        var list = jsonResponse["data"] as List;
        if (list.isNotEmpty) {
          subcategoryManager.homeScreenPopularList =
              list.map((e) => ProductsListModel.fromJson(e)).toList();
        }
        print(
            "homeScreenPopularList---${subcategoryManager.homeScreenPopularList}");
        onSuccess();
      } else {
        onError();
      }
    }
  }

  getAdminContact({onSuccess, onError}) async {
    var url = ConstantUrls.wsContactApi;
    Map<dynamic, dynamic>? jsonResponse =
        await api.getService(url: url, isNeedFullScreenLoader: false);
    print("URL---$url");
    if (jsonResponse != null) {
      if (jsonResponse["status_code"] == ResponseStatus.http412 ||
          jsonResponse["status_code"] == ResponseStatus.http422) {
        onError();
      } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
        // showAlert(ConstantText.somethingWentWrong);
        onError();
      } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
        subcategoryManager.adminContactNo =
            jsonResponse["phone_number"].toString();
        onSuccess();
      }
    }
  }
}
