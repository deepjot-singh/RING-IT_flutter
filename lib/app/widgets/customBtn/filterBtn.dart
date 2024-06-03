import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/modules/productListPage/view/productListView.dart';
import 'package:foodorder/app/modules/subcategoryList/manager/subcategoryListManager.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';
import 'package:foodorder/app/widgets/horizontalListView.dart';

class FilterBtnView extends StatefulWidget {
  FilterBtnView({
    super.key,
    this.filterData,
    this.manager,
    this.onProductPage,
    this.filterId,
    this.selectedIndex,
  });
  // var _tempArry = ["Food", "Grocery", "Cosmetic", "Medicine"];
  // var _tempArry2 = ["Atta", "Rice", "Tomato", "Flour"];
  // List<SubCategoryListModel>? typeData = [];
  List<HomeScreenCategoryModel>? filterData = [];
  var filterId;
  SubCategoryListManager? manager;
  var selectedIndex;
  bool? onProductPage;

  @override
  State<FilterBtnView> createState() => _FilterBtnViewState();
}

class _FilterBtnViewState extends State<FilterBtnView> {
  // var selectedId;
  var provider = ProductProvider();

  // var manager = SubCategoryListManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     print("onProductPage1- ${widget.selectedIndex}");
       print("onProductPage1- ${widget.selectedIndex.runtimeType}");
    if (widget.onProductPage == true) {
       widget.selectedIndex = widget.filterId;

      print("onProductPage- ${widget.filterId}");
      print("onProductPage- ${widget.selectedIndex.runtimeType}");
      getCategoryList(categoryId: widget.filterId ?? "", onRefresh: () {});
    }
  }

  getCategoryList({categoryId, onRefresh}) async {
    print("catId-${categoryId}");
    await widget.manager?.getCategory(
        needAppend: false,
        catId: categoryId,
        onRefresh: () {
          setState(() {});
          onRefresh();
        });
  }

  @override
  Widget build(BuildContext context) {
    
  //   print("onProductPage- ${widget.selectedIndex}");
    // print("jjjjj-${widget.selectedIndex}");
    return InkWell(
      onTap: () {
        _showBottomPopUp(
          context: context,
          filterData: widget.filterData,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.greyBg,
        ),
        height: 37,
        width: 90,
        child: Center(
          child: Text(
            capitalize(ConstantText.filter),
            style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(57, 57, 57, 1),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  void _showBottomPopUp({
    context,
    List<dynamic>? filterData,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: ((context, setState) {
            return Container(
                height: 350,
                width: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 30, top: 30, right: 20, bottom: 60),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(ConstantText.filter,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.filterData?.length ?? 0,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 10,
                                  );
                                },
                                // padding: EdgeInsets.only(
                                //     right: 7, left:7, top: 5, bottom: 5),
                                itemBuilder: (context, index) {
                                   print("llllljjjjl11-${widget.selectedIndex}");
                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "llllljjjjl-${widget.filterData![index].id}");
                                      //  selectedId = index;
                                      print("llllljjjjl-${index}");
                                      widget.selectedIndex = index;
                                      // if (widget.filterId != null) {
                                      //   widget.filterId = index.toString();
                                      // }
                                      widget.manager?.filterSubcategoryList =
                                          [];
                                      getCategoryList(
                                          categoryId:
                                              widget.filterData![index].id,
                                          onRefresh: () {
                                            setState(() {});
                                          });
                                    },
                                    child: (widget.selectedIndex ==
                                            widget.filterData![index].id)
                                        ? 
                                         Container(
                                          
                                            //   height: 10,
                                            // width: 80,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColor.redThemeClr),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColor.pureWhite),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: SizedBox(
                                                // width: 68,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    capitalize(widget
                                                            .filterData![index]
                                                            .name ??
                                                        ""),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColor.redThemeClr,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
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
                                                    color: (widget
                                                                .selectedIndex ==
                                                            index)
                                                        ? AppColor.redThemeClr
                                                        : Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: (widget.selectedIndex ==
                                                        index)
                                                    ? AppColor.pureWhite
                                                    : Color.fromRGBO(
                                                        227, 227, 227, 1)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: SizedBox(
                                                // width: 68,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    capitalize(widget
                                                            .filterData![index]
                                                            .name ??
                                                        ""),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          (widget.selectedIndex ==
                                                                  index)
                                                              ? AppColor
                                                                  .redThemeClr
                                                              : Color.fromRGBO(
                                                                  57,
                                                                  57,
                                                                  57,
                                                                  1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 30,
                            child: Text(ConstantText.type.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            child: HorizontalListComponent(
                              onTap: (value, name) {
                                print("value-${value + name}");
                                widget.manager?.subcategoryId = value;
                                widget.manager?.subcategoryName = name;
                                setState(() {});
                              },
                              //  selectedIndex: widget.filterData?.first.id,
                              typeData: widget.manager?.filterSubcategoryList,
                            ),
                          ),
                          Spacer(),
                          CustomButton(
                            height: 50,
                            shadow: false,
                            borderWidth: 0,
                            fontSize: 16,
                            radius: 10,
                            fontweight: FontWeight.bold,
                            title: ConstantText.filter.toUpperCase(),
                            background: (widget.manager?.subcategoryId == "")
                                ? AppColor.textFeildBdr
                                : AppColor.redThemeColor,
                            onTap: () {
                              (widget.manager?.subcategoryId != "")
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductsListView(
                                                categoryList: [],
                                                filterId: "",
                                                filterSubcategoryId: widget
                                                    .manager?.subcategoryId,
                                                filtersubCatName: widget
                                                    .manager?.subcategoryName,
                                              )))
                                  : null;
                            },
                          )
                        ])));
          }));
        });
  }
}
