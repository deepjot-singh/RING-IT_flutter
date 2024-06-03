import 'dart:convert';

import 'package:dio/dio.dart' as io;
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:http/http.dart';

class HomeScreenApi {
  
  var api = HttpService();
  HomeScreenManager manager;
  

  HomeScreenApi({required this.manager});
  

  // homeScreenDataRepresent() {
  //   return fetchHomeScreenData(onSuccess: (){});
  // }

  // fetchHomeScreenData({onSuccess}) async {
  //   try {
  //     var url = ConstantUrls.wsCategory;
  //     Map<dynamic, dynamic>? jsonResponse = await api.getService(url: url);
  //     print("Url--$url");
  //     if (jsonResponse != null) {
  //       if (jsonResponse["status_code"] == ResponseStatus.http412 ||
  //           jsonResponse["status_code"] == ResponseStatus.http422) {
  //         var errors = jsonResponse["errors"];
  //         var isMessageKeyAvail = errors.containsKey("message");
  //         if (isMessageKeyAvail) {}
  //         // onError();
  //       } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
  //         print("Response--$jsonResponse");
  //         showAlert(ConstantText.somethingWentWrong);
  //       } else if (jsonResponse["status_code"] == ResponseStatus.http200) {}
  //     }
  //     var list = jsonResponse!["data"] as
  //     List;
  //     print("data---$list");
  //     // print("status- ${responseBody['data']}");

  //     // var list = responseBody["data"] as List;
  //     print("Data--$list");
  //     var data = list.map((e) => Data.fromJson(e)).toList();
  //     print("data--------$data");

  //     return onSuccess(data);
  //   } catch (e) {
  //     showAlert(
  //       ConstantText.somethingWentWrong,
  //     );
  //   }
  // }

  fetchHomeScreenData({onSuccess}) async {
    try {
      var url = ConstantUrls.wsHomeScreenSubcategory;
      Map<dynamic, dynamic>? jsonResponse = await api.getService(url: url);
      print("URL---$url");
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {}
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          print("Response--$jsonResponse");
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          print('success=====');
          var list = jsonResponse["data"] as List;
          print("Subcategorydata---$list");
          List<HomeScreenCategoryModel> homeScreenList =
              list.map((e) => HomeScreenCategoryModel.fromJson(e)).toList();
          manager.homeScreenList.addAll(homeScreenList);
          return onSuccess();
        }
      }
      var list = jsonResponse!["data"]["subcategories"] as List;
      print("SUBSUB---$list");
      var data = list.map((e) => HomeScreenCategoryModel.fromJson(e)).toList();
      return onSuccess(data);
    } catch (e) {
      showAlert(ConstantText.somethingWentWrong);
    }
  }
}
