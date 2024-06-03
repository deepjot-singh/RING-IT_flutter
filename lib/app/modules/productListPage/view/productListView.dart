import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/checkOutPage/view/checkoutPageView.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/productListPage/component/variableProduct.dart';

import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/subcategoryList/manager/subcategoryListManager.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';

import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:foodorder/app/widgets/pullRefreshFooter/pullRefreshFooter.dart';
import 'package:foodorder/app/widgets/refreshController/refreshController.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../widgets/appBar/homeIconAppBar.dart';
import '../../../widgets/customBtn/filterBtn.dart';
import '../../../widgets/customBtn/sortBtn.dart';
import '../component/productListComponent.dart';
import 'package:foodorder/app/widgets/appBar/searchAppBar2.dart';

class ProductsListView extends StatefulWidget {
  ProductsListView(
      {super.key,
      this.subcategoryData,
      this.filterSubcategoryId,
      required this.categoryList,
      required this.filterId,
      this.filtersubCatName});
  HomeScreenCategoryModel? category;
  List<HomeScreenCategoryModel>? categoryList;
  SubCategoryListModel? subcategoryData;
  String? filterSubcategoryId;
  var filterId;

  String? filtersubCatName;
  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  var provider = ProductProvider();
  var manager = SubCategoryListManager();
  var userId;
  var token;
  var subCategoryId;
  var showSheet = 0;
  var carouselController;
  bool isSearchClick = false;

  @override
  void initState() {
    super.initState();
    provider = GlobalVariable.productProviderManager;
    carouselController = CarouselController();
    provider.productManager.controller = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print("onProductPage");
      print("jjjjjjjjjjjjjjjj==${widget.filterId}");
      // getCategoryList(widget.category);

      getCategoryList(widget.filterId);
      await getProducts(
          widget.subcategoryData?.id.toString() ?? widget.filterSubcategoryId);
      token = await LocalStore().getToken();
      userId = await LocalStore().getUserID();

      //f real user is there then only we will check the cartrecord
      if (token != 'null' && token.toString().isNotEmpty) {
        checkCartRecord();
      }
    });
  }

  getCategoryList(category) async {
    await manager.getCategory(
        needAppend: true,
        catId: category.toString(),
        onRefresh: () {
          // getProducts();
          setState(() {});
        });
    setState(() {});
  }

//get list of products
  getProducts(subcategoryData) async {
    print("tttt${subcategoryData}");
    subcategoryData =
        widget.subcategoryData?.id.toString() ?? widget.filterSubcategoryId;

    userId = await LocalStore().getUserID();
    print("widget.subcategoryId-${subcategoryData}");
    subCategoryId = subcategoryData;
    await getProductData();
  }

  getProductData({selectedValue = "", String? subcategoryData}) {
    provider.getProductsData(
        subCategoryId: subCategoryId, userId: userId, price: selectedValue);
  }
  // getProductData({needLoader = true}) {
  //   provider.getProductsData(
  //       subCategoryId: subCategoryId, userId: userId, needLoader: needLoader);
  //   provider.productManager.controller.loadComplete();
  //   provider.productManager.controller.refreshCompleted();
  // }

  checkCartRecord() async {
    await provider.getCartRecord();
  }

  TextEditingController searchTf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, object, child) {
      return Scaffold(
        appBar: isSearchClick
            ? searchView()
            : HomeIconAppBar(
                subcategoryId: widget.subcategoryData?.id,
                title: capitalize(widget.subcategoryData?.name.toString() ??
                    widget.filtersubCatName),
                onSearch: () {
                  isSearchClick = true;
                  provider.refresh();
                }),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.960),
        body: SafeArea(
          child:
              // manager.isLoading ? loaderList() :
              bodyView(),
          // child: manager.isLoading ? loaderList : bodyView()
        ),
        bottomSheet: provider.productManager.cartItemModel != null
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
          if (provider.productManager.selectionListManager.searchTF.text !=
              "") {
            provider.productManager.selectionListManager.searchTF.clear();
            provider.productManager.pageNo = 1;
            getProductData(
                selectedValue: provider.productManager.selectedOrder);
          }
        },
        controllr: provider.productManager.selectionListManager.searchTF,
        onChange: () {
          provider.productManager.selectionListManager.timerInputSearch(
              onSearch: () {
            provider.productManager.pageNo = 1;
            getProductData(
                selectedValue: provider.productManager.selectedOrder);
          });
        });
  }

  Widget bodyView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                        ),
                      ),
                    ),
                ],
              ),
              FilterBtnView(
                filterId: widget.filterId,
                onProductPage: true,
                selectedIndex: widget.subcategoryData?.id,
                manager: manager,
                filterData: widget.categoryList,
                // typeData: manager.subcategoryList,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
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
                getProductData(
                    subcategoryData: widget.subcategoryData?.id.toString() ??
                        widget.filterSubcategoryId,
                    selectedValue: provider.productManager.selectedOrder);
                provider.productManager.controller.loadComplete();
                provider.productManager.controller.refreshCompleted();
              },
              onLoading: () {
                provider.productManager.pageNo += 1;
                getProductData(
                    selectedValue: provider.productManager.selectedOrder);
                provider.productManager.controller.loadComplete();
                provider.productManager.controller.refreshCompleted();
              },
              child: provider.productManager.isLoading
                  ? loaderList()
                  : provider.productManager.productsList.isEmpty
                      ? noDataFound()
                      : GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount:
                              provider.productManager.productsList.length,
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
          ),
          provider.productManager.cartItemModel != null
              ? const SizedBox(
                  height: 40,
                )
              : const SizedBox(height: 0)
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
                        style: const TextStyle(
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
                errorMsg: provider.productManager.errorMsg,
                isMultiple: provider.productManager.isMultiple,
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
