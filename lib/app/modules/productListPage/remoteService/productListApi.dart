import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/productListPage/manager/productListManager.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class ProductsListNetworkManager {
  var api = HttpService();
  ProductsListManager productManager;
  ProductsListNetworkManager({
    required this.productManager,
  });

  productsList(
      {onSuccess,
      onError,
      subCategoryId,
      userId,
      needLoader,
      price = ""}) async {
    print('here');
    try {
      var finalUrl = ConstantUrls.wsProductList;
      var param = {
        "subcategory_id": subCategoryId,
        "page": productManager.pageNo,
        "limit": "10",
        "price": price,
        "search": productManager.selectionListManager.searchTF.text,
        "user_id": userId
      };
      print('get product params ${param}');
      Map<dynamic, dynamic>? jsonResponse = await api.postService(
          params: param, url: finalUrl, isNeedFullScreenLoader: needLoader);
      print('productListData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errorMsg = jsonResponse["message"];

          showAlert(errorMsg);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["data"];
          print("DATA----$data");
          if (data != null) {
            var list = data as List;
            List<ProductsListModel> productsDataList =
                list.map((e) => ProductsListModel.fromJson(e)).toList();
            if (productManager.pageNo == 1) {
              productManager.productsList = [];
            }
            productManager.productsList.addAll(productsDataList);
          }
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              // showAlert(msg: errorMsg);
            }
          }
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      print('print4');

      showAlert(ConstantText.somethingWentWrong);
    }
  }

  searchList({onSuccess, onError, subCategoryId, userId, text, filter}) async {
    print('here for searching');
    try {
      var finalUrl = ConstantUrls.wsProductList;
      var param = {
        "user_id": userId,
        "subcategory_id": subCategoryId,
        "search": text,
        "price": filter,
        "limit": 50,
        "page": productManager.pageNo
      };

      //  {
      //   "subcategory_id": subCategoryId,
      //   "page": productManager.pageNo,
      //   "limit": "10",
      //   "user_id": userId
      // };
      print('get product params ${param}');
      Map<dynamic, dynamic>? jsonResponse =
          await api.postService(params: param, url: finalUrl);
      print('searchDataList==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            // showAlert(msg: errors["message"].toString());
          }
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["data"];

          if (data != null) {
            var list = data as List;
            List<ProductsListModel> productsDataList =
                list.map((e) => ProductsListModel.fromJson(e)).toList();
            if (productManager.pageNo == 1) {
              productManager.searchproductsList = [];
            }
            productManager.searchproductsList.addAll(productsDataList);
          }
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              // showAlert(msg: errorMsg);
            }
          }
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      print('print4');

      showAlert(ConstantText.somethingWentWrong);
    }
  }
}
