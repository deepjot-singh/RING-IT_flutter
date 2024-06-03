import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';

// ignore: must_be_immutable
class ProductNestedListView extends StatelessWidget {
  ProductsListModel productsListModel;
  VariableProductModel variableProductModel;
  List<Variations> variations;
  Function(int, Variations)? onTap;
  Function onRefresh;
  List<int> selectedIds;
  bool needBorder = false;
  String errorMsg;
  int currentIndex = 0;

  ProductNestedListView(
      {super.key,
      required this.selectedIds,
      this.errorMsg = "",
      required this.onRefresh,
      this.needBorder = false,
      required this.productsListModel,
      required this.variableProductModel,
      this.onTap,
      required this.variations});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (variableProductModel.is_multiple == "0" && needBorder) ...[
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
                  Text(
                    "Choose Your ${capitalize(variableProductModel.attribute_name)}",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  view()
                ],
              ),
            ),
          ),
        ] else ...[
          Text(
            variableProductModel.attribute_name.toUpperCase(),
            style: const TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          view()
        ]
      ],
    );
  }

  view() {
    return variableProductModel.is_multiple == "1" ? listView() : gridView();
  }

  listView() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  variations[index].variationDetail.variation_name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.subTextColor),
                ),
              ),
              Text(
                variations[index].sale_price,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.subTextColor),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                variations[index].regular_price,
                style: TextStyle(
                    decoration: variations[index].sale_price != ""
                        ? TextDecoration.lineThrough
                        : null,
                    decorationColor: variations[index].sale_price != ""
                        ? Colors.grey
                        : AppColor.subTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: variations[index].sale_price != ""
                        ? Colors.grey
                        : AppColor.subTextColor),
              ),
              const SizedBox(width: 10),
              Container(
                  height: 20,
                  width: 20,
                  child: Transform.scale(
                      scale: .9,
                      child: Checkbox(
                          activeColor: AppColor.redThemeColor,
                          value: variations[index].isChecked,
                          onChanged: (value) {
                            variations[index].isChecked =
                                !variations[index].isChecked;
                            if (onTap != null) {
                              onTap!(
                                  variations[index].id ?? 0, variations[index]);
                            }
                          }))),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Divider(color: AppColor.dividerColor),
          );
        },
        itemCount: variations.length);
  }

  gridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (0.86 / .60),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10.0),
            itemCount: variations.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  currentIndex = index;
                  variableProductModel.errorMsg = "";
                  onRefresh();
                  if (onTap != null) {
                    onTap!(variations[index].id ?? 0, variations[index]);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1.5,
                        color: selectedIds.contains(variations[index].id)
                            ? AppColor.redThemeColor
                            : AppColor.borderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          variations[index].variationDetail.variation_name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: variations[index].sale_price != "" &&
                                  variations[index].regular_price != ""
                              ? 1
                              : variations[index].sale_price != "" ||
                                      variations[index].regular_price != ""
                                  ? 2
                                  : 3,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.subTextColor),
                        ),
                        if (variations[index].regular_price != "")
                          Text(
                            variations[index].regular_price,
                            style: TextStyle(
                                decoration: variations[index].sale_price != ""
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor:
                                    variations[index].sale_price != ""
                                        ? Colors.grey
                                        : AppColor.subTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: variations[index].sale_price != ""
                                    ? Colors.grey
                                    : AppColor.subTextColor),
                          ),
                        if (variations[index].sale_price != "")
                          Text(
                            variations[index].sale_price,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.subTextColor),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: 10,
        ),
        if (variableProductModel.errorMsg != "")
          Text(
            variableProductModel.errorMsg,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          )
      ],
    );
  }
}
