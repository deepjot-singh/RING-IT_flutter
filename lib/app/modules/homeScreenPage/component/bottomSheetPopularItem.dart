import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/checkOutPage/model/checkoutDetailsModel.dart';
import 'package:foodorder/app/modules/checkOutPage/view/checkOutPageView.dart';
import 'package:foodorder/app/modules/homeScreenPage/component/homePopularProductView.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/productListPage/component/variableProduct.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:foodorder/app/widgets/refreshController/refreshController.dart';
import 'package:provider/provider.dart';

class PopularItemsView extends StatefulWidget {
  ProductsListModel productModel;
  HomeScreenManager manager;

  PopularItemsView({required this.productModel, required this.manager});

  @override
  State<PopularItemsView> createState() => _PopularItemsViewState();
}

class _PopularItemsViewState extends State<PopularItemsView> {
  var provider = ProductProvider();
  var selectedItem1 = SelectionListManager();
  var selectedItemSize1 = SelectionListManager();
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = GlobalVariable.productProviderManager;
    selectedItem1 = provider.productManager.selectionListManager;
    selectedItemSize1 = provider.productManager.selectionListManager;
    clearVariableData();

    provider.productManager
        .checkRequired(variableList: widget.productModel.variableProduct);
    provider.productManager.calculateProductPrice(
        variableList: widget.productModel.variableProduct);
    print("MODEL==${widget.productModel.quantity}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      token = await LocalStore().getToken();
      getCheckoutData();
    });
  }

  getCheckoutData() {
    provider.getCartRecord();
  }

  clearVariableData() {
    widget.productModel.quantity = 0;
    if (widget.productModel.productType.toString() == "variable") {
      provider.productManager.clearErrorPopular();
      provider.productManager.clearCheckBoxProduct(
          productsListPopular: widget.manager.homeScreenPopularList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, object, child) {
      return Scaffold(
        //  bottomSheet: _bottomSheet(),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Stack(
            children: [
              HomePopularProductView(
                errorMsg: provider.productManager.errorMsg,
                isMultiple: provider.productManager.isMultiple,
                selectedIds: selectedItemSize1.selectedItemSize,
                productsListModel: widget.productModel,
                onRefresh: () {
                  setState(() {});
                  provider.refresh();
                },
                onAddRemove: (int variationId,
                    String isMultiple,
                    Variations variationModel,
                    List<Variations> variation,
                    VariableProductModel variableProductModel) {
                  if (isMultiple == "0") {
                    provider.productManager.addisMultipleZeroData(
                        variation: variation,
                        variableProductModel: variableProductModel,
                        selectedItemSize1: selectedItemSize1,
                        isPopular: true,
                        productsListPopular:
                            widget.manager.homeScreenPopularList,
                        variationId: variationId);

                    provider.productManager
                        .calculateProductPriceisMultipleZeroData(
                            variation: variation,
                            selectedItemSize1: selectedItemSize1,
                            variationsModel: variationModel);
                  } else {
                    provider.productManager.addisMultipleOneData(
                        selectedItem1: selectedItem1, variationId: variationId);
                    provider.productManager
                        .calculateProductPriceisMultipleOneData(
                            selectedItem1: selectedItem1,
                            variationsModel: variationModel);
                  }
                  provider.refresh();
                },
              ),
              Positioned(bottom: 0, left: 0, right: 0, child: _bottomSheet())
            ],
          ),
        ),
      );
    });
  }

  Widget _bottomSheet() {
    print(
        "widget.productModel.quantity${widget.productModel.quantity.toString()}");
    print(
        'provider.productManager.cartItemModel ${provider.productManager.cartItemModel}');
    return Consumer<ProductProvider>(builder: (context, object, child) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 90,
        child: provider.productManager.cartDetailLoader
            ? loaderListWithoutPadding()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (checkCart()) ...[
                          Text(
                            "${provider.productManager.cartItemModel?.totalItems} ITEMS",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "₹${provider.productManager.cartItemModel?.subTotal}",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                        ] else ...[
                          Text(
                            getPriceText(),
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          ),
                        ]
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (checkCart()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutScreenView(pageRefresh: () {
                                        widget.productModel.quantity = 0;
                                        if (widget.productModel.productType
                                                .toString() ==
                                            "variable") {
                                          provider
                                              .productManager
                                              .selectionListManager
                                              .selectedItem = [];
                                          provider
                                              .productManager
                                              .selectionListManager
                                              .selectedItemSize = [];
                                          provider.productManager.clearPricie(
                                              variableList: widget.productModel
                                                  .variableProduct);
                                          provider.productManager
                                              .clearCheckBoxProduct(
                                                  productsListPopular: widget
                                                      .manager
                                                      .homeScreenPopularList);
                                        } else {
                                          provider.refresh();
                                        }
                                        getCheckoutData();
                                      })));
                        } else {
                          if (token != 'null' && token.toString().isNotEmpty) {
                            provider.addToCartProduct(
                                productData: widget.productModel,
                                onSuccess: () {
                                  provider.refresh();
                                });
                          } else {
                            Routes.pushSimpleAndReplaced(
                                context: GlobalVariable.getRootContext(),
                                child: LoginView());
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.redThemeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20)),
                      child: Text(
                        checkCart() ? "VIEW CART" : "ADD TO CART",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  checkCart() {
    return widget.productModel.quantity.toString() != "null" &&
        widget.productModel.quantity.toString() != "0" &&
        provider.productManager.cartItemModel != null;
  }

  getPriceText() {
    if (widget.productModel.productType.toString() == "variable") {
      return "₹${provider.productManager.variablePrice.toString()}";
    } else {
      return widget.productModel.salePrice != ""
          ? "₹${widget.productModel.salePrice}"
          : "₹${widget.productModel.regularPrice}";
    }
  }
}
