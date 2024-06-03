import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/checkoutPage/view/checkoutPageView.dart';
import 'package:foodorder/app/modules/drawer/component/logoutDialogComponent.dart';
import 'package:foodorder/app/modules/drawer/component/settingListDesignComponent.dart';
import 'package:foodorder/app/modules/drawer/component/settingTitleComponent.dart';
import 'package:foodorder/app/modules/drawer/manager/drawerManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/orderHistoryPage/view/orderHistoryView.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/profile/manager/profileManager.dart';
import 'package:foodorder/app/modules/profile/provider/profileProvider.dart';
import 'package:foodorder/app/modules/profile/view/profileView.dart';
import 'package:foodorder/app/modules/subcategoryList/view/subcategoryListView.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatefulWidget {
  DrawerView(
      {super.key,
      required this.categories,
      required this.homeManager,
      required this.userAuthToken});
  HomeScreenManager homeManager;
  List<HomeScreenCategoryModel>? categories = [];
  var userAuthToken;

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  var provider = ProductProvider();

  var drawerManagerObject = DrawerManager();
  final drawerManager = DrawerManager();
  var profilemanager = ProfileManager();

  @override
  void initState() {
    super.initState();
    provider = GlobalVariable.productProviderManager;
    profilemanager = GlobalVariable.ProfileProviderManager.manager;
    print(
        'OBJECT-=-WJWHBEWH ${provider.productManager.cartItemModel?.totalItems}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Drawer(
        shape: const Border(
            right: BorderSide(
          width: 2,
          color: Colors.white,
        )),
        backgroundColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Consumer<ProfileProvider>(
                        builder: (context, object, child) {
                      return InkWell(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, left: 20),
                              child: Column(children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              // provider.manager.profileDataList.imgsrc ,
                                              profilemanager.profileDataList
                                                      ?.imgsrc ??
                                                  "",
                                          placeholder: (context, url) =>
                                              loaderList(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "assets/images/profileImage.png",
                                            height: 80,
                                          ),
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        capitalize(profilemanager
                                                .profileDataList?.name
                                                .toString() ??
                                            "Guest User"),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                          "${profilemanager.profileDataList?.country_code ?? ""}${profilemanager.profileDataList?.phone_no ?? "+91**********"}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400))
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(GlobalVariable.getRootContext());
                          widget.userAuthToken == "null" ||
                                  widget.userAuthToken.toString().isEmpty
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfileView(
                                        provider: GlobalVariable
                                            .ProfileProviderManager),
                                  ),
                                );
                        },
                      );
                    }),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(GlobalVariable.getRootContext());
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                          color: Color(0xffd9d9d9),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.close,
                          color: AppColor.blackstd,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SettingTitleComponent(
                title: ConstantText.categoriesCaps,
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: widget.categories?.length,
                  itemBuilder: (BuildContext context, int i) {
                    return SettingListDesignComponent(
                        listName: capitalize(widget.categories?[i].name),
                        callBack: () {
                          Navigator.pop(GlobalVariable.getRootContext());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategoryListView(
                                      categoryList:
                                          widget.homeManager.homeScreenList,
                                      category:
                                          widget.homeManager.homeScreenList[i],
                                    )),
                          );
                        },
                        listImage:
                            widget.homeManager.homeScreenList[i].image ?? "",
                        isNetwork: true);
                  }),
              SettingTitleComponent(
                title: ConstantText.userInformation,
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: drawerManager.userInfo.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Consumer<ProductProvider>(
                        builder: (context, value, child) {
                      return SettingListDesignComponent(
                          listImage: "",
                          itemCount: provider.productManager.cartItemModel
                                      ?.totalItems ==
                                  null
                              ? ""
                              : toInt() > 99
                                  ? "99+"
                                  : provider.productManager.cartItemModel
                                          ?.totalItems
                                          .toString() ??
                                      "",
                          isNeedCount: drawerManager.userInfo[i].page == 'cart'
                              ? true
                              : false,
                          listName:
                              capitalize(drawerManager.userInfo[i].labelText),
                          callBack: () {
                            Navigator.pop(GlobalVariable.getRootContext());
                            widget.userAuthToken == "null" ||
                                    widget.userAuthToken.toString().isEmpty
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginView(),
                                    ),
                                  )
                                : screenCalling(
                                    drawerManager.userInfo[i].page ?? 'orders',
                                    context);
                          },
                          listIcon: drawerManager.userInfo[i].imageName ??
                              (Icons.logout));
                    });
                  }),
              //hide logout section if guest mode
              if (widget.userAuthToken != "null" &&
                  widget.userAuthToken.toString().isNotEmpty &&
                  widget.userAuthToken != "" &&
                  widget.userAuthToken != null) ...[
                SettingTitleComponent(
                  title: ConstantText.generalSetting,
                ),
                const SizedBox(
                  height: 10,
                ),
                SettingListDesignComponent(
                    isAssets: true,
                    isNetwork: false,
                    color: Color(0xffCB202D),
                    listName: ConstantText.logOut,
                    callBack: () {
                      showLogoutDialog();
                    },
                    listImage: "assets/icons/icon-logout.png")
              ]
            ],
          ),
        ),
      ),
    );
  }

  screenCalling(String pageName, BuildContext context) {
    switch (pageName) {
      case 'cart':
        //Get.to(() => RewardStore());
        Routes.pushSimple(
            context: GlobalVariable.getRootContext(),
            child: CheckoutScreenView(
              pageRefresh: () {
                // provider.productManager.productsList = [];
                // provider.productManager.pageNo = 1;
                // getProductData();
                // // provider.productManager.cartItemModel
                // provider.getCartRecord();
              },
            ));
        break;

      case 'orders':
        Routes.pushSimple(
            context: GlobalVariable.getRootContext(),
            child: OrderHistoryView());
        //notification
        break;
    }
  }

  toInt() {
    if (provider.productManager.cartItemModel!.totalItems != null) {
      return int.parse(
          provider.productManager.cartItemModel!.totalItems.toString());
    } else {
      return "";
    }
  }
}
