import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/checkOutPage/view/checkOutPageView.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/productListPage/component/productListComponent.dart';
import 'package:foodorder/app/modules/productListPage/component/variableProduct.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/subcategoryList/manager/subcategoryListManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/widgets/appBar/homeIconAppBar.dart';
import 'package:foodorder/app/widgets/appBar/searchAppBar2.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:foodorder/app/widgets/pullRefreshFooter/pullRefreshFooter.dart';
import 'package:foodorder/app/widgets/refreshController/refreshController.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../widgets/customBtn/filterBtn.dart';
import '../../../widgets/customBtn/sortBtn.dart';
import '../component/subcategoryListComponent.dart';

class SubCategoryListView extends StatefulWidget {
  SubCategoryListView({super.key, required this.category, this.categoryList});
  HomeScreenCategoryModel category;
  List<HomeScreenCategoryModel>? categoryList = [];

  @override
  State<SubCategoryListView> createState() => _SubCategoryListView();
}

class _SubCategoryListView extends State<SubCategoryListView> {
  var manager = SubCategoryListManager();
  var provider = ProductProvider();
  var userId;
  var token;
  String subCategoryId = "";
  bool isSearchClick = false;

  @override
  void initState() {
    provider = GlobalVariable.productProviderManager;
    provider.productManager.controller = RefreshController();
    // print("catid ----- ${manager.subcategoryList.first.id}");
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCategoryList(widget.category);
    });
  }

  getProducts({subcategoryData}) async {
    provider.productManager.selectionListManager.searchTF.clear();
    provider.productManager.selectedValue = "";
    userId = await LocalStore().getUserID();

    // subCategoryId = subcategoryData.id.toString();
    await getProductData();
    if (token != 'null' && token.toString().isNotEmpty) {
      checkCartRecord();
    }
  }

  checkCartRecord() async {
    await provider.getCartRecord();
  }

  getProductData({selectedValue = ""}) {
    provider.getProductsData(
        subCategoryId: subCategoryId, userId: userId, price: selectedValue);
  }

//get list of restaurants
  getCategoryList(category) async {
    await manager.getCategory(
        needAppend: true,
        catId: category.id.toString(),
        onRefresh: () {
          getProducts();
          setState(() {});
        });
    setState(() {});
  }

// jjjjjjjjjjjjj
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, object, child) {
      return Scaffold(
        appBar: isSearchClick
            ? searchView()
            : HomeIconAppBar(
                // subcategoryId: manager.subcategoryList.first.id ?? "8",
                title: capitalize(widget.category.name.toString()),
                onSearch: () {
                  isSearchClick = true;
                  provider.refresh();
                },
              ),
        backgroundColor: isSearchClick
            ? Color.fromRGBO(255, 255, 255, 0.960)
            : AppColor.pureWhite,
        body: SafeArea(
            child:
                // manager.isLoading ? loaderList() :
                bodyView()),
        bottomSheet:
            isSearchClick && provider.productManager.cartItemModel != null
                ? _bottomSheet()
                : null,
      );
    });
  }

  searchView() {
    return SearchAppBar2(
      onClose: () {
        isSearchClick = false;
        provider.refresh();
        if (provider.productManager.selectionListManager.searchTF.text != "") {
          provider.productManager.selectionListManager.searchTF.clear();
          provider.productManager.pageNo = 1;
          getProductData(selectedValue: provider.productManager.selectedOrder);
        }
      },
      controllr: provider.productManager.selectionListManager.searchTF,
      onChange: () {
        provider.productManager.selectionListManager.timerInputSearch(
            onSearch: () {
          provider.productManager.pageNo = 1;
          getProductData(selectedValue: provider.productManager.selectedOrder);
        });
      },
    );
  }

  Widget bodyView() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isSearchClick) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SortBtnView(
                        provider: provider,
                        onTap: (selectedOrder) {
                          provider.productManager.selectedOrder = selectedOrder;
                          Navigator.of(context).pop();
                          provider.productManager.pageNo = 1;
                          getProductData(selectedValue: selectedOrder);
                        },
                      ),
                      if (provider.productManager.selectedOrder != "")
                        InkWell(
                            onTap: () {
                              provider.productManager.selectedValue = "";
                              provider.productManager.selectedOrder = "";
                              provider.productManager.pageNo = 1;
                              getProductData(selectedValue: "");
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColor.redThemeClr,
                                    size: 15,
                                  ),
                                )))
                    ],
                  ),
                  Container()
                ] else ...[
                  Container(),
                  FilterBtnView(
                    manager: manager,
                    selectedIndex: widget.category.id,
                    filterData: widget.categoryList,
                    // typeData: manager.subcategoryList,
                  ),
                ]
              ],
            ),
          ),
          isSearchClick
              ? productListView()
              : Expanded(
                  child: provider.productManager.isLoading
                      ? loaderList()
                      : manager.subcategoryList.isEmpty
                          ? const Center(child: Text("No data found"))
                          : GridView.builder(
                              //  physics: NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              padding: EdgeInsets.all(5),
                              scrollDirection: Axis.vertical,
                              itemCount: manager.subcategoryList.length,
                              // itemCount: tempList?.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: (0.90 / 1.30),
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 5.0),
                              itemBuilder: ((context, index) {
                                return SubCategoryListComponent(
                                    filterId: widget.category.id,
                                    subcategoryData:
                                        manager.subcategoryList[index],
                                    categoryList: widget.categoryList);
                              })),
                ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    print(
        'provider.productManager.cartItemModel ${provider.productManager.cartItemModel}');
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
          // Container()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${provider.productManager.cartItemModel?.totalItems} ITEMS",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "₹${provider.productManager.cartItemModel?.subTotal}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CheckoutScreenView(pageRefresh: () {
                                    provider.productManager.productsList = [];
                                    provider.productManager.pageNo = 1;
                                    getProductData();
                                    // provider.productManager.cartItemModel
                                    provider.getCartRecord();
                                  })));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.redThemeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20)),
                    child: const Text(
                      "View Cart",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  productListView() {
    return Expanded(
      child: SmartRefresher(
        footer: PullRefreshFooter.getPullRefreshFooter(),
        controller: provider.productManager.controller,
        enablePullUp: true,
        header: MaterialClassicHeader(
          color: Colors.white,
          backgroundColor: AppColor.togglebtn,
        ),
        enablePullDown: true,
        onRefresh: () {
          provider.productManager.pageNo = 1;
          getProductData(selectedValue: provider.productManager.selectedOrder);
          provider.productManager.controller.loadComplete();
          provider.productManager.controller.refreshCompleted();
        },
        onLoading: () {
          provider.productManager.pageNo += 1;
          getProductData(selectedValue: provider.productManager.selectedOrder);
          provider.productManager.controller.loadComplete();
          provider.productManager.controller.refreshCompleted();
        },
        child: provider.productManager.isLoading
            ? loaderListWithoutPadding()
            : provider.productManager.productsList.isEmpty
                ? const Center(child: Text("No data found"))
                : GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: provider.productManager.productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (0.86 / 1.2),
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemBuilder: ((context, index) {
                      return InkWell(
                        child: ProductsListComponent(
                          productProvider: provider,
                          token: token,
                          productData:
                              provider.productManager.productsList[index],
                          onTap: () {
                            setState(() {});
                          },
                          onAddClick: () {
                            provider.productManager.productsList[index]
                                .quantity = 0;
                            provider.productManager.clearError();
                            showBottomSheetofProduct(
                                productModel: provider
                                    .productManager.productsList[index]);
                          },
                        ),
                      );
                    })),
      ),
    );
  }

  showBottomSheetofProduct({required ProductsListModel productModel}) {
    SelectionListManager selectedItem1 =
        provider.productManager.selectionListManager;
    SelectionListManager selectedItemSize1 =
        provider.productManager.selectionListManager;
    provider.productManager
        .checkRequired(variableList: productModel.variableProduct);
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              height: 500,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                  child: VariableProductView(
                isMultiple: provider.productManager.isMultiple,
                errorMsg: provider.productManager.errorMsg,
                selectedIds: selectedItemSize1.selectedItemSize,
                onAddItemTap: () {
                  provider.addToCartProduct(
                      productData: productModel,
                      onSuccess: () {
                        setState(() {});
                        provider.refresh();
                      });
                  setState(() {});
                  provider.refresh();
                },
                onAddTap: () {
                  if (token != 'null' && token.toString().isNotEmpty) {
                    // provider.productManager.checkRequired(
                    //     variableList: productModel.variableProduct);
                    if (provider.productManager.dataVariableList?.length ==
                        selectedItemSize1.selectedItemSize.length) {
                      provider.productManager.clearMsg();
                      provider.addToCartProduct(
                          productData: productModel,
                          onSuccess: () {
                            setState(() {});
                            provider.refresh();
                          });
                    }
                  } else {
                    Routes.pushSimpleAndReplaced(
                        context: GlobalVariable.getRootContext(),
                        child: LoginView());
                  }
                  setState(() {});
                  provider.refresh();
                },
                onRemoveTap: () {
                  provider.removeFromCartProduct(
                      productData: productModel,
                      onSuccess: () {
                        setState(() {});
                        provider.refresh();
                      });
                  setState(() {});
                  provider.refresh();
                },
                productsListModel: productModel,
                onRefresh: () {
                  setState(() {});
                  provider.refresh();
                },
                onAddRemove: (int variationId,
                    String isMultiple,
                    List<Variations> variation,
                    VariableProductModel variableProductModel) {
                  if (isMultiple == "0") {
                    provider.productManager.addisMultipleZeroData(
                        variation: variation,
                        variableProductModel: variableProductModel,
                        selectedItemSize1: selectedItemSize1,
                        variationId: variationId);
                  } else {
                    provider.productManager.addisMultipleOneData(
                        selectedItem1: selectedItem1, variationId: variationId);
                  }
                  setState(() {});
                  provider.refresh();
                },
              )),
            );
          });
        });
  }
}
