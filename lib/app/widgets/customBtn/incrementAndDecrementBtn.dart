import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';

class IncrementAndDecrementBtn extends StatefulWidget {
  IncrementAndDecrementBtn({super.key, required this.quantity});
  var quantity;
  @override
  State<IncrementAndDecrementBtn> createState() =>
      _IncrementAndDecrementBtnState();
}

class _IncrementAndDecrementBtnState extends State<IncrementAndDecrementBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.redThemeClr,
      ),
      child: Row(
        children: [
          //  SizedBox(width: 0,),
          InkWell(
            onTap: () {
              setState(() {
                if (widget.quantity <= 0) {
                  widget.quantity = 0;
                } else {
                  widget.quantity--;
                }
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
            widget.quantity.toString(),
            style: TextStyle(color: Colors.white),
          ),
          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () {
          //     setState(() {
          //       widget.quantity++;
          //     });
          //   },
          // ),
          InkWell(
            onTap: () {
              setState(() {
                widget.quantity++;
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
      ),
    );
  }
}

class IncrementDecrementBtnChkOut extends StatefulWidget {
  IncrementDecrementBtnChkOut({super.key, required this.quantity});
  var quantity;
  @override
  State<IncrementDecrementBtnChkOut> createState() =>
      _IncrementDecrementBtnChkOutState();
}

class _IncrementDecrementBtnChkOutState
    extends State<IncrementDecrementBtnChkOut> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.remove,
            color: AppColor.pureWhite,
          ),
          onPressed: () {
              setState(() {
                // if (widget.quantity <= 0) {
                //   widget.quantity = 0;
                // } else {
                  widget.quantity--;
               // }
              });
          },
        ),
        Text(
          widget.quantity.toString(),
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            color: AppColor.pureWhite,
          ),
          onPressed: () {
            setState(() {
              widget.quantity++;
            });
          },
        ),
      ],
    );
  }
}
