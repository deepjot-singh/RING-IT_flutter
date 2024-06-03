import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/widgets/searchTf/searchTf.dart';

class SearchAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar2(
      {super.key,
      required this.controllr,
      required this.onChange,
      this.placeholder,
      required this.onClose});

  TextEditingController controllr = TextEditingController();
  Function()? onChange;
  Function()? onClose;
  String? placeholder;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Padding(
          padding: EdgeInsets.only(top: 53, left: 18, right: 18),
          child: Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SearchTF(
                    height: 44,
                    controllr: controllr,
                    background: Colors.white,
                    placeholder: "Search",
                    onChange: (value) {
                      onChange!();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (onClose != null) {
                    onClose!();
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.close,
                        color: AppColor.redThemeClr,
                        size: 25,
                      ),
                    )),
              )
            ],
          ))),
    );
  }

  void onPressedSearchButton() {}
  @override
  Size get preferredSize => const Size.fromHeight(90);
}
