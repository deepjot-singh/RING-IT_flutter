import 'dart:convert';

import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/productListPage/manager/productListManager.dart';
import 'package:foodorder/app/modules/productListPage/model/cartItemModel.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/profile/manager/updatePhonemanager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class CartApiNetworkManager {
  var api = HttpService();
  ProductsListManager productManager;
  CartApiNetworkManager({
    required this.productManager,
  });

  addToCart(
      {onSuccess,
      onError,
      productId,
      quantity,
      subcategoryId,
      isCheckoutPage = false,
      productType,
      productAttributeIds}) async {
    try {
      var finalUrl = ConstantUrls.wsAddToCart;
      var param;

      if (productType.toString() == "variable") {
        productManager.addTotal(
            isCheckoutPage: isCheckoutPage,
            productAttributeIds: productAttributeIds);

        param = {
          "product_id": productId,
          "subcategory_id": subcategoryId,
          "quantity": 1,
          "product_type": productType,
          "product_attribute_variable_id":
              productManager.selectionListManager.totalSelectedItem
        };
      } else {
        param = {
          "product_id": productId,
          "subcategory_id": subcategoryId,
          "quantity": 1,
          "product_type": productType
        };
      }
      print('add to cart params ${param}');
      Map<dynamic, dynamic>? jsonResponse = await api.postService(
          params: param, url: finalUrl, isNeedFullScreenLoader: false);
      print('cartData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422 ||
            jsonResponse["status_code"] == ResponseStatus.http401 ||
            jsonResponse["status_code"] == ResponseStatus.http500) {
          var errorMessage = jsonResponse["message"];
          showAlert(errorMessage);
          print("ERRORMSG--$errorMessage");
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["data"];
          if (data != null) {
            var list = data as List;
            List<ProductsListModel> productsDataList =
                list.map((e) => ProductsListModel.fromJson(e)).toList();
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
      print('print1');
      showAlert(ConstantText.somethingWentWrong);
    }
  }

  removeToCart(
      {onSuccess,
      onError,
      productId,
      quantity,
      productType,
      isCheckoutPage = false,
      productAttributeIds}) async {
    // waitDialog();
    try {
      var finalUrl = ConstantUrls.wsRemoveToCart;
      var param;
      if (productType.toString() == "variable") {
        productManager.addTotal(
            isCheckoutPage: isCheckoutPage,
            productAttributeIds: productAttributeIds);

        param = {
          "product_id": productId,
          "quantity": quantity,
          "product_type": productType,
          "product_attribute_variable_id":
              productManager.selectionListManager.totalSelectedItem
        };
      } else {
        param = {
          "product_id": productId,
          "quantity": quantity,
          "product_type": productType,
        };
      }
      print('add to cart params ${param}');
      Map<dynamic, dynamic>? jsonResponse = await api.postService(
          params: param, url: finalUrl, isNeedFullScreenLoader: false);
      print('cartData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errorMessage = jsonResponse["message"];
          showAlert(errorMessage);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["data"];
          if (data != null) {
            var list = data as List;
            List<ProductsListModel> productsDataList =
                list.map((e) => ProductsListModel.fromJson(e)).toList();
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
      print('print2');

      showAlert(ConstantText.somethingWentWrong);
    }
  }

  // get cart item price and item count
  getCartItemPrice({onSuccess, onError}) async {
    try {
      var finalUrl = ConstantUrls.wsGetCartItemPrice;
      var param = {
        "latitude": productManager.latitude,
        "longitude": productManager.longitude
      };
      print('get cart item price params ${param}');
      Map<dynamic, dynamic>? jsonResponse = await api.postService(
          params: param, url: finalUrl, isNeedFullScreenLoader: false);

      print('getCartItemPriceData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errorMessage = jsonResponse["message"];
          showAlert(errorMessage);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http401) {
          var errorMessage = jsonResponse["message"];
          //      showAlert(errorMessage);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["cart_record"];
          if (data.isNotEmpty) {
            productManager.cartItemModel = CartItemModel.fromJson(data);
          } else {
            productManager.cartItemModel = null;
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
      print('print3');

  //    showAlert(ConstantText.somethingWentWrong);
    }
  }
}
