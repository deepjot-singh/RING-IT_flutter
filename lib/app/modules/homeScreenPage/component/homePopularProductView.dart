import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/productListPage/component/productNestedListView.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/widgets/imagecatcher/imageCatcher.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePopularProductView extends StatelessWidget {
  ProductsListModel productsListModel;
  int currIndex = 0;
  Function onRefresh;
  String errorMsg;
  Function(int, String, Variations, List<Variations>, VariableProductModel)?
      onAddRemove;

  List<int> selectedIds;
  bool isMultiple = false;

  HomePopularProductView(
      {required this.productsListModel,
      required this.onRefresh,
      this.errorMsg = "",
      this.isMultiple = false,
      required this.selectedIds,
      required this.onAddRemove});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bodyView(context);
  }

  bodyView(context) {
    final List<Widget> imageSliders = productsListModel.imageListModel
        .map((productImage) => ImageCatcher(imgURL: productImage.image))
        .toList();
    return SingleChildScrollView(
      child: Consumer<ProductProvider>(builder: (context, object, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.black, size: 20)),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  print("INDEX${currIndex}");
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            productsListModel.imageListModel
                                                .length, (index) {
                                          print("index123$index");
                                          return Container(
                                            width: 7.0,
                                            height: 7.0,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2.0),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          productsListModel.name ?? "",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColor.headingtextColor,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (productsListModel.shortDescription != "")
                          Text(
                            productsListModel.shortDescription ?? "",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w300,
                                fontFamily: "Nunito"),
                          ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (productsListModel.productType == "regular") ...[
                singleData()
              ] else ...[
                if (!isMultiple) ...[singleData()],
                // const SizedBox(height: 20),
                listView(),
              ],
              const SizedBox(height: 100)
            ],
          ),
        );
      }),
    );
  }

  Widget singleData() {
    return Column(
      children: [
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
    );
  }

  listView() {
    print("LENGTH${productsListModel.variableProduct.length}");
    return Column(
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProductNestedListView(
                needBorder: true,
                errorMsg: productsListModel.variableProduct[index].errorMsg,
                selectedIds: selectedIds,
                onRefresh: () {
                  onRefresh();
                },
                onTap: (variationId,variations) {
                  productsListModel.quantity = 0;
                  if (onAddRemove != null) {
                    onAddRemove!(
                        variationId,
                        productsListModel.variableProduct[index].is_multiple,
                        variations,
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
}
