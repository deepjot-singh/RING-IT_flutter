import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/productListPage/component/productListComponent.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/widgets/appBar/searchAppBar.dart';
import 'package:foodorder/app/widgets/customBtn/clearFilterBtn.dart';
import 'package:foodorder/app/widgets/customBtn/sortBtn.dart';
import 'package:foodorder/app/widgets/pullRefreshFooter/pullRefreshFooter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SreachScreenView extends StatefulWidget {
  SreachScreenView({super.key, required this.subCategoryId});
  String? subCategoryId;
  @override
  State<SreachScreenView> createState() => _SreachScreenViewState();
}

class _SreachScreenViewState extends State<SreachScreenView> {
  var provider = ProductProvider();
  var userId;
  var token;
  // var subCategoryId;
  var showSheet = 0;
  String? searchText;
  String? filterData;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    provider = GlobalVariable.productProviderManager;
    provider.productManager.controller = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      print("id1-- ${widget.subCategoryId}");
      await getProducts(widget.subCategoryId);
      token = await LocalStore().getToken();
      userId = await LocalStore().getUserID();

      //f real user is there then only we will check the cartrecord
      if (token != 'null' && token.toString().isNotEmpty) {
        checkCartRecord();
      }
    });
  }

  //get list of products
  getProducts(subcategoryData) async {
    userId = await LocalStore().getUserID();

    // subCategoryId = widget.subcategoryData?.id.toString();
    await searchData("", "");
  }

  // getProductData() {
  //   print("id2-- ${widget.subcategoryData?.id}");
  //   provider.getProductsData(
  //       subCategoryId: widget.subcategoryData?.id.toString(), userId: userId);
  //   provider.productManager.controller.loadComplete();
  //   provider.productManager.controller.refreshCompleted();
  // }

  searchData(searchText, filter) {
    print("id2-- ${widget.subCategoryId}");
    print("textSearch2-- ${searchText}");
    print("textSearch2-- ${filter}");
    provider.getSearchData(
        text: searchText.toString(),
        filter: filterData.toString() == "null" ? "" : filterData.toString(),
        subCategoryId: widget.subCategoryId.toString(),
        userId: userId);
    provider.productManager.controller.loadComplete();
    provider.productManager.controller.refreshCompleted();
  }

  checkCartRecord() async {
    await provider.getCartRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, object, child) {
      return Scaffold(
          appBar: SearchAppBar(
            onChange: (text) {
              if (text.length >= 3) {
                print("Searching for ${text}");
                searchText = text;
                Future.delayed(Duration(seconds: 3), () {
                  searchData(searchText, "");
                });
              }
              // searchData(searchText);
            },
            placeholder: ConstantText.searchHere,
            controllr: searchController,
          ),
          body: bodyView());
    });
  }

  Widget bodyView() {
    return (provider.productManager.searchproductsList.isEmpty)
        ? Center(
            child: Text(ConstantText.noResultFound),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SortBtnView(
                      provider: provider,
                      onTap: (value) {
                        searchData(searchText, filterData);
                        setState(() {});
                      },
                    )
                  ],
                ),
                ClearBtnComponent(
                  onTap: () {},
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
                      searchData("", "");
                    },
                    onLoading: () {
                      provider.productManager.pageNo += 1;
                      searchData("", "");
                    },
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount:
                            provider.productManager.searchproductsList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (0.87 / 1.2),
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0),
                        itemBuilder: ((context, index) {
                          return InkWell(
                            child: ProductsListComponent(
                              productProvider: provider,
                              token: token,
                              productData: provider
                                  .productManager.searchproductsList[index],
                              onTap: () {
                                setState(() {});
                              },
                            ),
                          );
                        })),
                  ),
                ),
              ],
            ),
          );
  }
}
