import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/addAddressPage/view/addAddressPageView.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/notificationPage/view/notificationPageView.dart';
import 'package:foodorder/app/modules/settingPage/view/settingView.dart';

class CustomHomeIconAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomHomeIconAppBar(
      {super.key,
      this.needBackIcon = false,
      this.title = "",
      this.backBtnAction});

  String title;
  bool needBackIcon;
  Function()? backBtnAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  if (backBtnAction != null) {
                    backBtnAction!();
                  }
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios,
                    //Icons.arrow_back_ios,
                    // color: Colors.white,
                    color: Colors.black,
                    size: 20
                    //  DeviceUtil.isTablet ? 18.sp : 20.sp
                    )),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'NunitoSans',
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w800),
            ),
            Container(
              width: 50,
            ),
          ]),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(80.0);

  // Size getHeight() {
  //   return 90,
  // }
}

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar(
      {super.key,
      required this.token,
      required this.currAddress,
      required this.homeManager});
  String currAddress = "";
  dynamic token;
  HomeScreenManager homeManager;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool openDrawer = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffb0d9bb),
            Color(0xffd7e8db),
            Color(0xffF5F5F5),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          color: AppColor.pureWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   ConstantText.deliveryTo,
              //   style: TextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.w400,
              //       color: Color.fromARGB(255, 83, 83, 83)),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        widget.homeManager.key.currentState!.openDrawer();
                      },
                      child: Icon(Icons.menu)),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // token == "null" || token.toString().isEmpty || token == ""
                      //     ? Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => LoginView(),
                      //         ),
                      //       )
                      //     :
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAddressPageView(
                            confirmbtn: true,
                            confirmAddress: (address) {
                              widget.currAddress = address;
                              print("curr==${widget.currAddress}");
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(ConstantText.deliveryTo,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff292D32),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              child: Text(
                                widget.currAddress,
                                // "HayStreet, Perth",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              settingSection(),
            ],
          ),
        ),
      ),
    );
  }

  settingSection() {
    return Row(
      children: [
        InkWell(
          child: Icon(
            Icons.account_circle_outlined,
            size: 25,
          ),
          onTap: () {
            Navigator.push(GlobalVariable.getRootContext(),
                MaterialPageRoute(builder: (context) => SettingPageView()));
          },
        ),
        InkWell(
          child: Icon(
            Icons.notifications,
            size: 25,
          ),
          onTap: () {
            widget.token == "null" ||
                    widget.token.toString().isEmpty ||
                    widget.token == ""
                ? Navigator.push(
                    GlobalVariable.getRootContext(),
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  )
                : Navigator.push(
                    GlobalVariable.getRootContext(),
                    MaterialPageRoute(
                      builder: (context) => const NotificationPageView(),
                    ),
                  );
          },
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
