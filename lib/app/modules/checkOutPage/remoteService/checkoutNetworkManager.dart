import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/modules/checkoutPage/manager/checkoutManager.dart';
import 'package:foodorder/app/modules/checkoutPage/model/checkoutDetailsModel.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/otpVerify/view/otpVerifyView.dart';
import 'package:foodorder/app/modules/productListPage/manager/productListManager.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:lottie/lottie.dart';

class CheckoutNetworkManager {
  var api = HttpService();
  CheckoutManager checkoutManager;
  ProductsListManager productManager;
  CheckoutNetworkManager(
      {required this.checkoutManager, required this.productManager, context});

  checkoutList({onSuccess, onError, isNeedFullPageLoader = false}) async {
    try {
      var finalUrl = ConstantUrls.wsGetCartItems;
      var param = {};
      Map<dynamic, dynamic>? jsonResponse = await api.postService(
          params: param,
          url: finalUrl,
          isNeedFullScreenLoader: isNeedFullPageLoader);
      print('finalUrl ====$finalUrl');
      print('checkoutData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["message"].toString();
          showAlert(errors);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          var data = jsonResponse["data"];
          print("jjjjjjjjjjj$data");
          if (data != null) {
            //if data, then only add the response into model
            var list = data as List;
            if (list.isNotEmpty) {
              checkoutManager.checkoutDetailData = [];
              List<CheckoutDetailModel> dataList =
                  list.map((e) => CheckoutDetailModel.fromJson(e)).toList();
              checkoutManager.checkoutDetailData.addAll(dataList);
            } else {
              //else stop the loader
              //redirect to home page because no item in the cart
              // Navigator.pop(GlobalVariable.getRootContext());
            }
          }

          //if remove the quantity from the checkout page
          //and quantity is equal to zero then need to full screen loader to stop the actions
          if (isNeedFullPageLoader) dismissWaitDialog();

          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var errorMsg = jsonResponse["message"].toString();
          showAlert(errorMsg);

          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      print('print4 ${e}');
      showAlert(ConstantText.somethingWentWrong);
    }
  }

  placeOrder(
      {onSuccess, onError, paymentmode, required BuildContext? context}) async {
    try {
      var finalUrl = ConstantUrls.wsPlaceOrder;
      var param = {
        "payment_mode": paymentmode,
        "longitude": productManager.longitude,
        "latitude": productManager.latitude,
        "order_user_address": productManager.userPlaceOrderAddress
      };
      print('place order param ${param}');
      Map<dynamic, dynamic>? jsonResponse =
          await api.postService(params: param, url: finalUrl);
      print('finalUrl ====$finalUrl');
      print('PlaceorderData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["message"].toString();
          showAlert(errors);
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          // checkoutManager.checkoutDetailData = [];
          //make cart items model null when order placed successfully
          //make the total items of cart empty
          var successMsg = jsonResponse["message"].toString();
          print("jjjjjj-${successMsg}");
          print("jjjjjj-${successMsg.runtimeType}");
          //       showAlert(successMsg, onTap: () {

          // //         showDialog(

          // //     context: context,
          // //     builder: (_) => Container(child: Lottie.asset("assets/animations/ordersuccessanimation.json"),)
          // // );
          //         Routes.pushSimple(
          //             context: GlobalVariable.getRootContext(),
          //             child: HomeScreenView());
          //       });

          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var errorMsg = jsonResponse["message"].toString();
          showAlert(errorMsg);
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      print('print4 ${e}');
      showAlert(ConstantText.somethingWentWrong);
    }
  }
}
