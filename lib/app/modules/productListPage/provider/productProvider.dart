import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/addressBookPage/manager/addressBookManager.dart';
import 'package:foodorder/app/modules/checkoutPage/manager/checkoutManager.dart';
import 'package:foodorder/app/modules/checkoutPage/remoteService/checkoutNetworkManager.dart';
import 'package:foodorder/app/modules/productListPage/manager/productListManager.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/remoteService/cartApi.dart';
import 'package:foodorder/app/modules/productListPage/remoteService/productListApi.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  var productManager = ProductsListManager();
  var checkoutManager = CheckoutManager();
  var addressBookManager = AddressBookManager();

  /// get product list

  getProductsData({
    subCategoryId,
    userId,
    price = "",
    needLoader,
  }) async {
    if (productManager.pageNo == 1) {
      productManager.isLoading = true;
    }
    refresh();
    print('pending');
    await ProductsListNetworkManager(productManager: productManager)
        .productsList(
            price: price,
            needLoader: false,
            onSuccess: () {
              print('success');
              productManager.isLoading = false;
              refresh();
            },
            onError: () {
              productManager.isLoading = false;
              refresh();
            },
            subCategoryId: subCategoryId,
            userId: userId);
  } //add to cart

  getSearchData({subCategoryId, userId, required text, String? filter}) async {
    productManager.isLoading = true;
    refresh();
    print('pending');
    await ProductsListNetworkManager(productManager: productManager).searchList(
        onSuccess: () {
          print('success');
          productManager.isLoading = false;
          refresh();
        },
        onError: () {
          productManager.isLoading = false;
          refresh();
        },
        subCategoryId: subCategoryId,
        text: text,
        filter: filter,
        userId: userId);
  }

  addToCartProduct(
      {required ProductsListModel productData,
      onSuccess,
      isCheckoutPage = false}) async {
    print('addtocartmethod');
    refresh();
    productData.loader = true;
    refresh();

    // Future.delayed(Duration(seconds: 5),(){
    //   productData.loader = false;
    // refresh();
    // });
    await CartApiNetworkManager(productManager: productManager).addToCart(
        onSuccess: () {
          productData.loader = false;
          //update the cart record whenever user add the items into the cart
          getCartRecord();
          productData.quantity = productData.quantity! + 1;
          refresh();
          if (onSuccess != null) {
            onSuccess();
          }
        },
        onError: () {
          productData.loader = false;
          refresh();
        },
        productType: productData.productType,
        productId: productData.id,
        quantity: productData.quantity! + 1,
        subcategoryId: productData.subcategoryId,
        isCheckoutPage: isCheckoutPage,
        productAttributeIds: productData.productAttributeVariableId);
  }

  //add to cart
  removeFromCartProduct(
      {required ProductsListModel productData,
      isCheckoutPage = false,
      onSuccess}) async {
    print('removetocartmethod');
    productData.loader = true;
    refresh();
    await CartApiNetworkManager(productManager: productManager).removeToCart(
        onSuccess: () {
          print('successisCheckoutPage ${isCheckoutPage}');
          productData.loader = false;
          //update the cart record whenever user add the items into the cart
          getCartRecord();

          //if quantity 0 then get the cart products again to get latest record
          //hit below method only if request from the checkout page
          if (isCheckoutPage && productData.quantity! - 1 == 0) {
            print('checkRecord Data');
            checkoutManager.checkoutDetailData = [];
            getCheckoutProductsList(isNeedFullPageLoader: true);
          }
          productData.quantity = productData.quantity! - 1;
          refresh();
          if (onSuccess != null) {
            onSuccess();
          }
        },
        onError: () {
          productData.loader = false;
          refresh();
        },
        productId: productData.id,
        quantity: productData.quantity! - 1,
        productType: productData.productType,
        isCheckoutPage: isCheckoutPage,
        productAttributeIds: productData.productAttributeVariableId);
  }

  //check logged user has any product in the cart with the current subcategory
  getCartRecord() async {
    productManager.cartDetailLoader = true;
    refresh();
    await CartApiNetworkManager(productManager: productManager)
        .getCartItemPrice(
      onSuccess: () {
        productManager.cartDetailLoader = false;
        refresh();
      },
      onError: () {
        productManager.cartDetailLoader = false;

        refresh();
      },
    );
  }

  //get cart items on checkout page
  getCheckoutProductsList({isNeedFullPageLoader = false, context}) async {
    checkoutManager.isLoader = true;
    refresh();
    await CheckoutNetworkManager(
      checkoutManager: checkoutManager,
      productManager: productManager,
    ).checkoutList(
        onSuccess: () {
          checkoutManager.isLoader = false;
          refresh();
        },
        onError: () {
          checkoutManager.isLoader = false;
          refresh();
        },
        isNeedFullPageLoader: isNeedFullPageLoader);
  }

//place order method
  placeOrder({required paymentmode, context,onSuccess}) async {
    print('oredrplace');
    await CheckoutNetworkManager(
            checkoutManager: checkoutManager, productManager: productManager)
        .placeOrder(
      context: context,
      onSuccess: () {
        checkoutManager.isLoader = false;
        if(onSuccess!=null){
          onSuccess();
        }
        refresh();
      },
      onError: () {
        checkoutManager.isLoader = false;
        refresh();
      },
      paymentmode: paymentmode,
    );
  }

// while oredr user can change the address
  getUserPlaceOrderAddress({
    selectedAddress,
    needPop = true,
  }) {
    print('here hhhhhh ${selectedAddress}');
    productManager.userPlaceOrderAddress =
        '${selectedAddress.houseNumber}, ${capitalize(selectedAddress.locality)},${selectedAddress.landmark != 'null' ? selectedAddress.landmark : ""}, ${selectedAddress.pincode}\nPhone Number: ${selectedAddress.countryCode} ${selectedAddress.phoneNumber}';
    productManager.userPlaceOrderAddressType =
        capitalize(selectedAddress.addressType);
    productManager.latitude = selectedAddress.latitude;
    productManager.longitude = selectedAddress.longitude;
    //hit cart item price api to get the delivery charges against the selected location
    getCartRecord();
    refresh();
    if (needPop) Navigator.of(GlobalVariable.getRootContext()).pop();
  }

  refresh() {
    GlobalVariable.productProviderManager.notifyListeners();
  }
}
