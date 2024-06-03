import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/checkOutPage/view/checkoutPageView.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/restaurantListPage/manager/restaurantListManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/customBtn/clearFilterBtn.dart';

import '../../../widgets/appBar/homeIconAppBar.dart';
import '../../../widgets/customBtn/filterBtn.dart';
import '../../../widgets/customBtn/sortBtn.dart';
import '../../singleRestaurantPage/view/singleResaturantPage.dart';
import '../component/restaurantListComponent.dart';

class RestaurantsListView extends StatefulWidget {
  const RestaurantsListView({super.key});

  @override
  State<RestaurantsListView> createState() => _RestaurantsListViewState();
}

class _RestaurantsListViewState extends State<RestaurantsListView> {
  var manager = RestaurantListManager();
  var provider = ProductProvider();

  var quantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getData();
    });
  }

//get list of restaurants
  getData() async {
    await manager.getRestaurantListData();
    setState(() {});
    print('restaurants data');
  }

  TextEditingController searchTf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("rateee--${manager.restaurantList.first.rate}");
    print("vvvvvv22--${quantity}");
    return Scaffold(
      appBar: HomeIconAppBar(
        title: "Grocery",
      ),
      // CustomHomeIconAppBar(
      //   title: "Restaurants",
      //   needBackIcon: false,
      // ),
      backgroundColor: AppColor.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Container(
              //   color: Color.fromARGB(255, 249, 246, 246),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8),
              //     child: TextField(
              //       style: TextStyle(
              //           color: Colors.black), //<-- SEE HERE
              //       controller: searchTf,
              //       onTap: (() {}),
              //       onChanged: ((value) {}),
              //       decoration: InputDecoration(
              //         icon: Icon(Icons.search),
              //         fillColor: Colors.amber,
              //         isDense: true,
              //         border: InputBorder.none,
              //         hintText: 'Search "Food"', //
              //         // hintStyle: TextStyle(color: Constant().isDarkModeApp() ? AppColor.appLight : AppColor.appDark,),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SortBtnView(provider: provider,), FilterBtnView()],
              ),

              ClearBtnComponent(
                onTap: () {},
              ),
              Expanded(
                child: GridView.builder(
                    //  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: manager.restaurantList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (0.87 / 1.2),
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemBuilder: ((context, index) {
                      return InkWell(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               SingleRestaurantPage()));
                        // },
                        child: ResListComponent(
                          manager: manager.restaurantList[index],
                          onTap: (value) {
                            setState(() {
                              print("vvvvvv--${value}");

                              print("vvvvvv--${value.runtimeType}");
                              quantity = value;
                            });
                          },
                        ),
                      );
                    })),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: (quantity >= 1) ? _BottomSheet() : null,
    );
  }

  Widget _BottomSheet() {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2 ITEMS",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                Text(
                  "₹280.00",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             CheckoutScreenView()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.redThemeClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
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
}
