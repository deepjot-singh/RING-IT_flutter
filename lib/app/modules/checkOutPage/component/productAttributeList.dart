import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';
import 'package:foodorder/app/widgets/dottedLine/dottedLine.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class ProductAttributeList extends StatelessWidget {
  ProductAttributeList({super.key, required this.checkoutProductData});
  ProductsListModel checkoutProductData;
  dynamic token;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  itemView(
                      variableProduct:
                          checkoutProductData.variableProduct[index])
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: checkoutProductData.variableProduct.length)
      ],
    );
  }

  itemView({required VariableProductModel variableProduct}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                variableProduct.attribute_name.toUpperCase(),
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        view(variableProduct: variableProduct)
      ],
    );
  }

  view({required VariableProductModel variableProduct}) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Text(
                variableProduct
                    .variations[index].variationDetail.variation_name,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w200),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 2,
              );
            },
            itemCount: variableProduct.variations.length));
  }
}
