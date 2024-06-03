import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/addAddressPage/view/addAddressPageView.dart';
import 'package:foodorder/app/modules/drawer/view/drawerView.dart';
import 'package:foodorder/app/modules/homeScreenPage/component/bottomSheetPopularItem.dart';
import 'package:foodorder/app/modules/homeScreenPage/component/subcategoryListComponent.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/profile/manager/profileManager.dart';
import 'package:foodorder/app/modules/profile/provider/profileProvider.dart';
import 'package:foodorder/app/modules/subcategoryList/view/subcategoryListView.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';
import 'package:foodorder/app/modules/notificationPage/view/notificationPageView.dart';
import 'package:foodorder/app/modules/settingPage/view/settingView.dart';
import 'package:foodorder/app/services/firbaseSerivce/updateDeviceTokenService.dart';
import 'package:foodorder/app/services/getLocation/getLocation.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/imagecatcher/homeScreenImageCatcher.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:foodorder/app/widgets/pullRefreshFooter/pullRefreshFooter.dart';
import 'package:foodorder/app/widgets/refreshController/refreshController.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomeScreenView extends StatefulWidget {
  HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeCreenViewState();
}

class _HomeCreenViewState extends State<HomeScreenView> {
  bool openDrawer = false;
  var token;
  var manager = HomeScreenManager();
  final GlobalKey<ScaffoldState> myKey = GlobalKey();
  var provider = ProductProvider();
  var profileProvider = ProfileProvider();
  var profilemanager = ProfileManager();

  // var subcategoryManager = HomeScreenManager();
  String currAddress = "";
  String currlat = "";
  String currlng = "";
  var cartItem = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('tokentoken $token');
    provider = GlobalVariable.productProviderManager;
    profileProvider = GlobalVariable.ProfileProviderManager;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      token = await LocalStore().getToken();
      var deviceToken = await LocalStore().getFCMToken();
      getProfileData();
      getlocation();

      if (token != "null" &&
          token.toString().isNotEmpty &&
          token != "" &&
          token != null) {
        UpdateDeviceToken().updateToken(deviceToken: deviceToken);
      }
      getPopularItems();
      getHomeScreenSubcategory();
      getContact();
      getCheckoutData();
    });
  }

  getContact() {
    manager.getAdminContact(onRefresh: () {
      setState(() {});
    });
  }

  getlocation() async {
    await LocationDetector().getLocation(onRefresh: () {
      setState(() {});
    }, onSuccess: (fullAddress, latt, lngg) {
      print('imcurrent $fullAddress');
      currAddress = fullAddress;
      currlat = latt.toString();
      currlng = lngg.toString();
      provider.productManager.userPlaceOrderAddress = fullAddress;
      provider.productManager.latitude = currlat;
      provider.productManager.longitude = currlng;
    });
    setState(() {});
  }

  getHomeScreenSubcategory() {
    manager.homeScreenDataRepresent(onRefresh: () {
      setState(() {});
    });
  }

  getPopularItems() {
    manager.getPopularItems(onRefresh: () {
      setState(() {});
    });
  }

  getProfileData() {
    profileProvider.clear();
    profileProvider.profileDataRepresent(needLoader: false);
  }

  
  getCheckoutData() {
    provider.getCartRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: manager.key,
      appBar: HomeAppBar(
          token: token, currAddress: currAddress, homeManager: manager),
      body: bodyView(token),
      drawer: DrawerView(
          categories: manager.homeScreenList,
          homeManager: manager,
          userAuthToken: token),
    );
  }

  bodyView(token) {
    return Container(
      color: const Color(0xffEFEFEF),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  controller: manager.controller,
                  header: MaterialClassicHeader(
                    color: Colors.white,
                    backgroundColor: AppColor.togglebtn,
                  ),
                  footer: PullRefreshFooter.getPullRefreshFooter(),
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () {
                    // manager.pageNo = 1;
                    getPopularItems();
                    getHomeScreenSubcategory();
                    manager.controller.loadComplete();
                    manager.controller.refreshCompleted();
                  },
                  // onLoading: () {
                  //   getHomeScreenSubcategory();

                  //   manager.controller.loadComplete();
                  //   manager.controller.refreshCompleted();
                  // },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 25,
                                    height: 2,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Color.fromARGB(255, 98, 173, 132),
                                          Color(0xffB3DABD),
                                        ],
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    capitalize(ConstantText.popularItems),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 25,
                                    height: 2,
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          Color.fromARGB(255, 98, 173, 132),
                                          Color(0xffB3DABD),
                                        ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomRight)),
                                  ),
                                ],
                              ),
                            )),
                        manager.isLoadingPopular
                            ? loaderList()
                            : manager.homeScreenPopularList.isEmpty
                                ? SizedBox(
                                    height: 100,
                                    child: Center(
                                        child: noDataFound(
                                            text:
                                                "No popular items available")))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(5),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          manager.homeScreenPopularList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: (1 / 1.10),
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 3,
                                      ),
                                      itemBuilder: ((context, index) {
                                        return InkWell(
                                            onTap: () {
                                              print(
                                                  "catid ----- ${manager.homeScreenPopularList[index].name}");

                                              Routes.pushSimple(
                                                  context: context,
                                                  child: PopularItemsView(
                                                      manager: manager,
                                                      productModel: manager
                                                              .homeScreenPopularList[
                                                          index]));
                                            },
                                            child: categoryList(
                                                categoryIndex: manager
                                                        .homeScreenPopularList[
                                                    index]));
                                      }),
                                    ),
                                  ),
                        const Divider(
                          color: Color(0xffC1C1C1),
                        ),
                        manager.isLoading
                            ? loaderList()
                            : manager.homeScreenList.isEmpty
                                ? SizedBox(
                                    height: 100,
                                    child: Center(child: noDataFound()))
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 22, bottom: 10, top: 10),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            manager.homeScreenList.length,
                                        itemBuilder: (context, index) {
                                          return SubcategoryListComponent(
                                              categoryList:
                                                  manager.homeScreenList,
                                              mainlist:
                                                  manager.homeScreenList[index],
                                              categoryData: manager
                                                  .homeScreenList[index]
                                                  .subcategoryList);
                                        }),
                                  ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                  onTap: () {
                        if (manager.adminContactNo != "" &&
                            manager.adminContactNo != "null") {
                          UrlLauncher.launch("tel:${manager.adminContactNo}");
                        }
                      },
                child: Container(
                  color: const Color(0xffEFEFEF),
                  child: Column(
                    children: [
                      const Divider(
                        color: Color(0xffC1C1C1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 2,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Color.fromARGB(255, 98, 173, 132),
                                  Color(0xffB3DABD),
                                ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            capitalize(ConstantText.contactUsText),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 25,
                            height: 2,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Color.fromARGB(255, 98, 173, 132),
                                  Color(0xffB3DABD),
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // manager.adminContactNo != "" &&
                        //         manager.adminContactNo != "null"
                        //     ? manager.adminContactNo
                        //     : 
                            "+91 8146962162",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        "assets/icons/contactUsBottom.png",
                        width: 180,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  categoryList({required ProductsListModel categoryIndex}) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
          // width: MediaQuery.of(context).size.width * 0.25,
          child: HomeScreenImageCatcher(
            imgURL: categoryIndex.imageListModel.isNotEmpty
                ? categoryIndex.imageListModel[0].image.toString()
                : "http://foodservice.codeoptimalsolutions.com/storage/products/1713333280630614.jpg",
          ),
        ),
        Text(
          capitalize(categoryIndex.name.toString()),
          style: const TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        )
      ],
    );
  }

  toInt() {
    return int.parse(
        provider.productManager.cartItemModel?.totalItems.toString() ?? "");
  }
}
