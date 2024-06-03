import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/productListPage/component/productNestedListView.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/widgets/imagecatcher/imageCatcher.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

// ignore: must_be_immutable
class VariableProductView extends StatelessWidget {
  ProductsListModel productsListModel;
  int currIndex = 0;
  Function onRefresh;
  Function(int, String, List<Variations>, VariableProductModel)? onAddRemove;
  Function() onAddTap;
  Function onAddItemTap;
  String errorMsg;
  Function onRemoveTap;
  List<int> selectedIds;
  bool isMultiple = false;

  VariableProductView(
      {required this.productsListModel,
      required this.onRefresh,
      this.onAddRemove,
      this.errorMsg = "",
      this.isMultiple = false,
      required this.selectedIds,
      required this.onAddTap,
      required this.onAddItemTap,
      required this.onRemoveTap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyView();
  }

  bodyView() {
    final List<Widget> imageSliders = productsListModel.imageListModel
        .map((productImage) => ImageCatcher(imgURL: productImage.image))
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColor.dividerColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            productsListModel.name ?? "",
            style: TextStyle(
                fontSize: 16,
                color: AppColor.headingtextColor,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  enableInfiniteScroll:
                      productsListModel.imageListModel.length == 1
                          ? false
                          : true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    currIndex = index;
                    currIndex = index;
                    onRefresh();
                  },
                  viewportFraction: 1),
            ),
          ),
          Container(
              child: productsListModel.imageListModel.length == 1
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              productsListModel.imageListModel.length, (index) {
                            return Container(
                              width: 7.0,
                              height: 7.0,
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: AppColor.redThemeColor,
                                color: currIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            );
                          }),
                        ),
                      ),
                    )),
          if (!isMultiple) ...[
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  "₹${productsListModel.regularPrice}",
                  style: TextStyle(
                      decoration: productsListModel.salePrice != ""
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: productsListModel.salePrice != ""
                          ? Colors.grey
                          : AppColor.subTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: productsListModel.salePrice != ""
                          ? Colors.grey
                          : AppColor.subTextColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "₹${productsListModel.salePrice}",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColor.subTextColor),
                ),
              ],
            )
          ],
          const SizedBox(height: 20),
          listView(),
          const SizedBox(height: 20),
          addButton()
        ],
      ),
    );
  }

  listView() {
    return Column(
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductNestedListView(
                errorMsg: productsListModel.variableProduct[index].errorMsg,
                selectedIds: selectedIds,
                onRefresh: () {
                  onRefresh();
                },
                onTap: (variationId, variations) {
                  productsListModel.quantity = 0;
                  if (onAddRemove != null) {
                    onAddRemove!(
                        variationId,
                        productsListModel.variableProduct[index].is_multiple,
                        productsListModel.variableProduct[index].variations,
                        productsListModel.variableProduct[index]);
                  }
                },
                productsListModel: productsListModel,
                variableProductModel: productsListModel.variableProduct[index],
                variations: productsListModel.variableProduct[index].variations,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20);
            },
            itemCount: productsListModel.variableProduct.length)
      ],
    );
  }

  addButton() {
    return Column(
      children: [
        productsListModel.loader
            ? Container(
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColor.redThemeColor, width: 1.5)),
                child: loaderListWithoutPadding(color: AppColor.redThemeColor),
              )
            : InkWell(
                child: Container(
                  child: (productsListModel.quantity == 0)
                      ? InkWell(
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColor.redThemeColor, width: 1.5)),
                            child: Center(
                              child: Text(
                                ConstantText.add,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.redThemeColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          onTap: () {
                            onAddTap();
                          },
                        )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.redThemeColor,
                          ),
                          height: 42,
                          width: MediaQuery.of(GlobalVariable.getRootContext())
                              .size
                              .width,
                          child: productsListModel.loader
                              ? loaderListWithoutPadding()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        onRemoveTap();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          child: Icon(
                                            Icons.remove,
                                            color: AppColor.pureWhite,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      productsListModel.quantity.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        onAddItemTap();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          child: Icon(
                                            Icons.add,
                                            color: AppColor.pureWhite,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                ),
              )
      ],
    );
  }
}
