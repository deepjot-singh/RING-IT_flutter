import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/modules/productListPage/provider/productProvider.dart';

class SortBtnView extends StatefulWidget {
  SortBtnView({super.key, this.onTap, required this.provider});
  Function(String)? onTap;
  var provider = ProductProvider();
  @override
  State<SortBtnView> createState() => _SortBtnViewState();
}

class _SortBtnViewState extends State<SortBtnView> {
  var provider = ProductProvider();
  List<String> options = ['Price (low to high)', 'Price (high to low)'];
  String selectedOrder = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = widget.provider;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showBottomPopUp(
          context: context,
        );
      },
      child: Container(
        height: 37,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.greyBg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_upward,
              size: 13,
              color: Color.fromRGBO(57, 57, 57, 1),
            ),
            Icon(
              Icons.arrow_downward,
              size: 13,
              color: Color.fromRGBO(57, 57, 57, 1),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              ConstantText.sort,
              style: TextStyle(
                  fontFamily: "NunitoSans",
                  fontSize: 16,
                  color: Color.fromRGBO(57, 57, 57, 1),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomPopUp({BuildContext? context}) {
    showModalBottomSheet(
        context: context!,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
                height: 200,
                width: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              child: Text(ConstantText.sortBy,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          Column(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: options.map((option) {
                              return RadioListTile<String>(
                               contentPadding: EdgeInsets.only(left:10),
                               visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity),
                                title: Text(
                                  option,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(57, 57, 57, 1)),
                                ),
                                value: option,
                                toggleable: true,
                                activeColor: AppColor.redThemeColor,
                                groupValue:
                                    provider.productManager.selectedValue,
                                onChanged: (value) {
                                  provider.productManager.selectedValue =
                                      value!;
                                  if (provider.productManager.selectedValue ==
                                      "Price (low to high)") {
                                    selectedOrder = "ASC";
                                    print("Selected Order: $selectedOrder");
                                    if (widget.onTap != null) {
                                      widget.onTap!(selectedOrder);
                                    }
                                  } else if (provider
                                          .productManager.selectedValue ==
                                      "Price (high to low)") {
                                    selectedOrder = "DESC";
                                    print("Selected Order: $selectedOrder");
                                    if (widget.onTap != null) {
                                      widget.onTap!(selectedOrder);
                                    }
                                  }

                                  setState(() {});
                                },
                              );
                            }).toList(),
                          ),
                        ])));
          });
        });
  }
}
