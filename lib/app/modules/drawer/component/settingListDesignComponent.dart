import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';

class SettingListDesignComponent extends StatelessWidget {
  SettingListDesignComponent(
      {super.key,
      required this.listName,
      required this.callBack,
      required this.listImage,
      this.isNetwork = false,
      this.color,
      this.isNeedCount = false,
      this.isAssets = false,
      this.itemCount = "",
      this.listIcon = Icons.logout,
      this.iconColor = Colors.green});
  String listName;
  String listImage;
  Function callBack;
  bool isNetwork = false;
  bool isAssets = false;
  Color? color;
  bool isNeedCount = false;
  String itemCount = "";
  IconData listIcon = Icons.logout;
  Color iconColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            callBack();
          },
          child: Row(
            children: [
              Container(
                  height: 27,
                  width: 27,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isNetwork
                          ? ClipOval(
                              child: Image.network(
                                listImage,
                                width: 25,
                                height: 25,
                              ),
                            )
                          : isAssets
                              ? Image.asset(
                                  listImage,
                                  width: 17,
                                  height: 17,
                                )
                              : ClipOval(
                                  child: Icon(
                                    listIcon,
                                    color: iconColor,
                                    size: 20,
                                  ),
                                ),
                    ],
                  )),
              const SizedBox(
                width: 8,
              ),
              Text(
                '$listName',
                style: TextStyle(
                    color: color,
                    fontWeight:
                        FontWeight.lerp(FontWeight.w500, FontWeight.w500, 9)),
              ),
              if (isNeedCount) ...[
                SizedBox(
                  width: 6,
                ),
                itemCount != ""
                    ? Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: FittedBox(
                              child: Text(
                                itemCount,
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      )
                    : Container(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
