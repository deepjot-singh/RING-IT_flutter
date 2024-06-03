import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar({super.key, this.controllr, this.onChange, this.placeholder});

  TextEditingController? controllr = TextEditingController();
  Function(String)? onChange;
  String? placeholder;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Padding(
          padding: EdgeInsets.only(top: 53, left: 18, right: 18),
          child: Container(
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 275,
                  decoration: BoxDecoration(
                    color: AppColor.textFeildBdr,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: onPressedSearchButton,
                          icon: Icon(Icons.search)),
                      Container(
                        width: 160,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            cursorColor: Colors.black,
                            textAlignVertical: TextAlignVertical.center,
                            // maxLines: null,
                            // controller: controllr,
                            style: TextStyle(fontSize: 16),
                            onChanged: (text) => {onChange!(text)},
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: placeholder,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            autofocus: false,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void onPressedSearchButton() {}
  @override
  Size get preferredSize => const Size.fromHeight(90);
}
