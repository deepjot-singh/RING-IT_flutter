import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';

import 'package:foodorder/app/widgets/imagecatcher/imageCatcher.dart';

import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:provider/provider.dart';

class ProductsListComponent extends StatefulWidget {
  ProductsListComponent(
      {super.key,
      required this.productData,
      this.onTap,
      this.token,
      this.onAddClick,
      required this.productProvider});
  ProductsListModel productData;

  ProductProvider productProvider;
  Function()? onTap;
  dynamic token;
  Function()? onAddClick;

  @override
  State<ProductsListComponent> createState() => _ProductsListComponentState();
}

class _ProductsListComponentState extends State<ProductsListComponent> {
  int currIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("kkkkk");
    final List<Widget> imageSliders = widget.productData.imageListModel
        .map((productImage) => ImageCatcher(imgURL: productImage.image))
        .toList();
    //  var index = productData.image//ListModel
    return Consumer<ProductProvider>(builder: (context, value, child) {
      return Container(
        // color: Color.fromARGB(255, 255, 255, 255),

        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        //   //     // color: Colors.amber
        //   ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // productProvider.productManager.productsList[1].
            CarouselSlider(
              // carouselController: carouselController,

              items: imageSliders,

              options: CarouselOptions(
                  enableInfiniteScroll:
                      widget.productData.imageListModel.length == 1
                          ? false
                          : true,
                  enlargeCenterPage: true,
                  height: 130,
                  onPageChanged: (index, reason) {
                    currIndex = index;
                    setState(() {
                      currIndex = index;
                    });
                  },
                  viewportFraction: 1),
            ),

            Container(
                child: widget.productData.imageListModel.length == 1
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                widget.productData.imageListModel.length,
                                (index) {
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
            // Image.asset(
            //   "assets/images/restaurant.png",
            //   fit: BoxFit.contain,
            // ),
            // CachedNetworkImage(
            //   imageUrl: productData.image.toString(),
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 2, right: 5, left: 5),
              child: Text(
                capitalize(widget.productData.name.toString()),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.productData.productType.toString() != "variable"
                        ? Column(
                            children: [
                              (widget.productData.salePrice != '0')
                                  ? Text(
                                      "₹${widget.productData.salePrice}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Container(),
                              (widget.productData.salePrice == '0')
                                  ? Text(
                                      "₹${widget.productData.regularPrice}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      "₹${widget.productData.regularPrice}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    )
                            ],
                          )
                        : Container(),
                    if (widget.productData.productType.toString() ==
                        "variable") ...[
                      InkWell(
                        child: Container(
                          height: 32,
                          width: 62,
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
                          if (widget.onAddClick != null) {
                            widget.onAddClick!();
                          }
                        },
                      )
                    ] else ...[
                      widget.productData.loader
                          ? Container(
                              height: 32,
                              width: 62,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColor.redThemeColor,
                                      width: 1.5)),
                              child: loaderListWithoutPadding(
                                  color: AppColor.redThemeColor),
                            )
                          : InkWell(
                              child: Container(
                                child: (widget.productData.quantity == 0)
                                    ? InkWell(
                                        child: Container(
                                          height: 32,
                                          width: 62,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: AppColor.redThemeColor,
                                                  width: 1.5)),
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
                                          widget.token != 'null' &&
                                                  widget.token
                                                      .toString()
                                                      .isNotEmpty
                                              ? widget.productProvider
                                                  .addToCartProduct(
                                                  productData:
                                                      widget.productData,
                                                )
                                              : Routes.pushSimpleAndReplaced(
                                                  context: GlobalVariable
                                                      .getRootContext(),
                                                  child: LoginView());
                                        },
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColor.redThemeColor,
                                        ),
                                        height: 35,
                                        width: 62,
                                        child: widget.productData.loader
                                            ? loaderListWithoutPadding()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print('remove');
                                                      widget.productProvider
                                                          .removeFromCartProduct(
                                                              productData: widget
                                                                  .productData);
                                                      widget.onTap!();
                                                    },
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColor.pureWhite,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.productData.quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      widget.productProvider
                                                          .addToCartProduct(
                                                        productData:
                                                            widget.productData,
                                                      );
                                                      widget.onTap!();
                                                    },
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColor.pureWhite,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                              ),
                            )
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
