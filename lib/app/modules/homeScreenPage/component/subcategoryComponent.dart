import 'package:flutter/material.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/homeScreenPage/manager/homeScreenManager.dart';

import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/productListPage/view/productListView.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/widgets/imagecatcher/homeScreenImageCatcher.dart';
import 'package:foodorder/app/widgets/imagecatcher/imageCatcher.dart';

class SubcategoryComponent extends StatefulWidget {
  SubcategoryComponent(
      {super.key,
      required this.subcategoryList,
      required this.filterId,
      required this.categoryList});
  SubCategoryListModel subcategoryList;
  var filterId;
  List<HomeScreenCategoryModel>? categoryList;
  @override
  State<SubcategoryComponent> createState() => _SubcategoryComponentState();
}

class _SubcategoryComponentState extends State<SubcategoryComponent> {
  var subCategoryManager = HomeScreenManager();

  @override
  Widget build(BuildContext context) {
    print("kljnnkjnkj-${widget.subcategoryList.name}");
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsListView(
                      filterId: widget.filterId,
                      categoryList: widget.categoryList,
                      subcategoryData: widget.subcategoryList,
                    )));
      },
      child: Column(
        children: [
          Container(
            height: 160,
            width: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: Color.fromARGB(255, 77, 199, 110)),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17))),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(17),
                            topRight: Radius.circular(17)),
                        child: SizedBox(
                          height: 120,
                          child: HomeImageCatcher(
                            imgURL: widget.subcategoryList.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(17),
                            bottomLeft: Radius.circular(17))),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      capitalize('${widget.subcategoryList.name}'),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          shadows: <Shadow>[Shadow(color: Colors.black)],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
