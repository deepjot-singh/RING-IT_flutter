import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/searchScreen/view/searchScreenView.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';

import '../../core/appColor/appColor.dart';

class HomeIconAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeIconAppBar({super.key, this.title, this.subcategoryId, this.onSearch});
  String? title;
  String? subcategoryId;
  Function? onSearch;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 2), () {
    // print("idd--${subcategoryId.toString()}");
    // });
    return Container(
      color: AppColor.pureWhite,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 10,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios,
                          //Icons.arrow_back_ios,
                          // color: Colors.white,
                          color: Colors.black,
                          size: 20
                          //  DeviceUtil.isTablet ? 18.sp : 20.sp
                          )),
                  Container(
                    width: 205,
                    child: Text(
                      title ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'NunitoSans',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => HomeScreenView()));
                    },
                    child: Container(
                      child: Icon(
                        Icons.home_outlined,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (onSearch != null) {
                        onSearch!();
                      }
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //         builder: (context) => SreachScreenView(
                      //             subCategoryId: "" //subcategoryId ?? "8",
                      //             )));
                    },
                    child: Container(
                      child: Icon(Icons.search, size: 25),
                    ),
                  )
                ],
              ),
            ]),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100.0);
}
