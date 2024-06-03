import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/singleRestaurantPage/manager/singleResturantManager.dart';
import 'package:foodorder/app/modules/singleRestaurantPage/model/singleRestaurantModel.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';

import '../../settingPage/view/settingView.dart';

class SingleRestaurantPage extends StatefulWidget {
  SingleRestaurantPage({super.key});

  @override
  State<SingleRestaurantPage> createState() => _SingleRestaurantPageState();
}

class _SingleRestaurantPageState extends State<SingleRestaurantPage> {
  var manager = SingleRestaurantManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getRestaurantData();
    });
  }

  getRestaurantData() async {
    await manager.getSingleRestaurantData();
    setState(() {});
    print("Restaurant Food ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(),
      body: restaurantInfo(manager, context),
    );
  }
}

restaurantInfo(manager, BuildContext context) {
  return SingleChildScrollView(
    child: SafeArea(
      child: GestureDetector(
      
        child: Scrollbar(interactive: true,
          child: Container(
            color: Color.fromRGBO(233, 233, 233, 1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      width: double.infinity,
                      
                      child:  Card(color: Color.fromRGBO(255, 255, 255, 1),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 24, left: 15, right: 15, bottom: 24),
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "The Halal Guys",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Image.asset("assets/images/forward_share.png",height: 20,width: 20,),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(Icons.favorite_outline)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "4.3",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(Icons.star,
                                      size: 19,
                                      color: AppColor.redThemeColor),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "200+ Ratings",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: AppColor.redThemeColor,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "Outlet",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    "Ranjit Avenue",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 22,
                                    color: AppColor.redThemeColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 12,
                                    color: AppColor.redThemeColor,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "25-30 min",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    "Delivery to Sco 94 ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    size: 22,
                                    color: AppColor.redThemeColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.pedal_bike),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "2.5 km",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "|",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Free Delivery on your order",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 20, right: 20, bottom: 15),
                    child: Column(
                      children: [
                        Center(child: Text("Menu")),
                        SafeArea(
                            child: Image.asset(
                          'assets/images/menudecoration.png',
                          height: 10,
                        )),
                        Row(
                          children: [
                            SafeArea(
                                child: Image.asset(
                              'assets/images/vegicon.png',
                              height: 22,
                              width: 42,
                            )),
                            const SizedBox(
                              width: 9,
                            ),
                            SafeArea(
                                child: Image.asset(
                              'assets/images/nonvegicon.png',
                              height: 22,
                              width: 42,
                            )),
                            SizedBox(height: 15,)
                          ],
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recommended",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w800),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SafeArea(
                            child: ListView.builder(
                              physics:NeverScrollableScrollPhysics(),
                              
                              shrinkWrap: true,
                              itemCount: manager.restaurantDataList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(manager
                                          .restaurantDataList![index].name
                                          .toString()),Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SafeArea(
                                child: Image.asset(
                              'assets/images/burger.png',
                              height: 110,
                              width: 110,
                            )),
                            const SizedBox(
                              width: 15,
                            ),
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Classic Burger",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Bun with aloo patty and \nsauces included ",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Rs 80 ",
                                  style: TextStyle(
                                      color: AppColor.redThemeColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),SizedBox(height: 8,)
                          ],
                        )
                                          
                                   
                                  ],
                                );
                              },
                            )
                            ),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "Buger",
                        //       style: TextStyle(
                        //           fontSize: 14, fontWeight: FontWeight.w400),
                        //     )
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     SafeArea(
                        //         child: Image.asset(
                        //       'assets/images/burger.png',
                        //       height: 110,
                        //       width: 110,
                        //     )),
                        //     const SizedBox(
                        //       width: 15,
                        //     ),
                        //     const Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Classic Burger",
                        //           style: TextStyle(
                        //               fontSize: 18, fontWeight: FontWeight.w700),
                        //         ),
                        //         Text(
                        //           "Bun with aloo patty and \nsauces included ",
                        //           style: TextStyle(
                        //               fontSize: 16, fontWeight: FontWeight.w400),
                        //         ),
                        //         SizedBox(height: 20),
                        //         Text(
                        //           "Rs 80 ",
                        //           style: TextStyle(
                        //               color: Color.fromRGBO(203, 32, 45, 1),
                        //               fontSize: 16,
                        //               fontWeight: FontWeight.w400),
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


