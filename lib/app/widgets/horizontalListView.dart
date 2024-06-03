import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';

import '../core/stringFomart/stringFormat.dart';

class HorizontalListComponent extends StatefulWidget {
  HorizontalListComponent(
      {super.key, required this.typeData, required this.onTap});
  List<dynamic>? typeData = [];

  Function(String, String) onTap;

  @override
  State<HorizontalListComponent> createState() =>
      _HorizontalListComponentState();
}

class _HorizontalListComponentState extends State<HorizontalListComponent> {
  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // print("jjjj22-${widget.typeData}");
    // print("jjjj223-${widget.selectedIndex}");

    return Container(
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.typeData!.length,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10,
            );
          },
          //   padding: EdgeInsets.only(right: 7, top: 5, bottom: 5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  print("kkkk-${index}");
                  selectedIndex = index;
                  widget.onTap(widget.typeData![index].id,
                      widget.typeData![index].name ?? "");
                  //  setState(() {});
                  print("kkkk2-${selectedIndex}");
                });
              },
              child: (selectedIndex == widget.typeData![index].id)
                  ? Container(
                      //   height: 10,
                      // width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.redThemeClr),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.pureWhite),
                      child: SizedBox(
                        // width: 68,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            capitalize(widget.typeData![index].name),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.redThemeClr,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      //   height: 10,
                      // width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (selectedIndex == index)
                                  ? AppColor.redThemeClr
                                  : Colors.transparent),
                          borderRadius: BorderRadius.circular(8),
                          color: (selectedIndex == index)
                              ? AppColor.pureWhite
                              : Color.fromRGBO(227, 227, 227, 1)),
                      child: SizedBox(
                        // width: 68,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              capitalize(widget.typeData![index].name ?? ""),
                              style: TextStyle(
                                fontSize: 12,
                                color: (selectedIndex == index)
                                    ? AppColor.redThemeClr
                                    : Color.fromRGBO(57, 57, 57, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            );
          }),
    );
  }
}
