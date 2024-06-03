import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/restaurantListPage/manager/restaurantListManager.dart';
import 'package:foodorder/app/widgets/customBtn/incrementAndDecrementBtn.dart';

import '../../../widgets/customBtn/addBtn.dart';

class ResListComponent extends StatefulWidget {
  ResListComponent({super.key, required this.manager, this.onTap});
  var manager;
  Function(int)? onTap;
  @override
  State<ResListComponent> createState() => _ResListComponentState();
}

class _ResListComponentState extends State<ResListComponent> {
  var quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: AppColor.pureWhite),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.manager.image.toString()),
          // const SizedBox(
          //   height: 4,
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 2,right: 5,left: 5),
            child: Text(
              widget.manager.name.toString(),
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
                children: [
                  Column(
                    children: [
                      Text(
                        "₹${widget.manager.rate.toString()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "₹${widget.manager.rate.toString()}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Container(
                      child: (quantity == 0)
                          ? InkWell(
                              child: AddBtnComponent(),
                              onTap: () {
                                setState(() {
                                  quantity++;
                                  print("quantty--${quantity}");
                                  widget.onTap!(quantity);
                                });
                              },
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.redThemeClr,
                              ),
                              height: 35,
                              width: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // if (quantity <= 0) {
                                        //   quantity = 0;
                                        // } else {
                                        quantity--;
                                        widget.onTap!(quantity);
                                        // }
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.remove,
                                        color: AppColor.pureWhite,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                        widget.onTap!(quantity);
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColor.pureWhite,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                              // IncrementAndDecrementBtn(
                              //     quantity: quantity,
                              //   ),
                              ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
