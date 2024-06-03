import 'package:flutter/material.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/homeScreenPage/component/subcategoryComponent.dart';

import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';

import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/modules/subcategoryList/view/subcategoryListView.dart';

class SubcategoryListComponent extends StatefulWidget {
  SubcategoryListComponent({
    super.key,
    required this.categoryData,
    required this.mainlist,
    required this.categoryList,
  });
  HomeScreenCategoryModel mainlist;
  List<SubCategoryListModel> categoryData;

  List<HomeScreenCategoryModel>? categoryList;
  @override
  State<SubcategoryListComponent> createState() =>
      _SubcategoryListComponentState();
}

class _SubcategoryListComponentState extends State<SubcategoryListComponent> {
  var manager = HomeScreenManager();
  var subCategoryManager = HomeScreenManager();

  @override
  Widget build(BuildContext context) {
    // print("qqqqqq${widget.subcategoryList.length}");
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              capitalize("${widget.mainlist.name}"),
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            //  Spacer(),
            (widget.categoryData.length <= 1)
                ? Container()
                : InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryListView(
                                category: widget.mainlist,
                                categoryList: widget.categoryList)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "See all",
                        style: TextStyle(
                            fontFamily: "NunitoSans",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(52, 168, 83, 1)),
                      ),
                    ),
                  ),
          ],
        ),
        Container(
          height: 170,
          alignment: Alignment.topLeft,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.categoryData.length,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            itemBuilder: (context, index) {
              return SubcategoryComponent(
                  filterId: widget.categoryData[index].id,
                  categoryList: widget.categoryList,
                  subcategoryList: widget.categoryData[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          ),

          // GridView.builder(
          //   shrinkWrap: true,
          //   padding: EdgeInsets.only(top: 5,bottom: 5),
          //   physics: NeverScrollableScrollPhysics(),
          //   // scrollDirection: Axis.vertical,
          //   itemCount: (widget.categoryData.length <= 4)
          //       ? widget.categoryData.length
          //       : 4,

          //   // widget.categoryData.subcategoryList.length,

          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     childAspectRatio: (7/ 4.7),
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 8,
          //   ),
          //   itemBuilder: ((context, index) {
          //     return SubcategoryComponent(
          //       filterId: widget.categoryData[index].id ,
          //       categoryList: widget.categoryList ,
          //         subcategoryList: widget.categoryData[index]);
          //     // categoryList(manager.homeScreenList[index]);
          //   }),
          // ),
        ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }
}
