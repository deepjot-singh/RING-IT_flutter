import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/subcategoryList/manager/subcategoryListManager.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/modules/homeScreenPage/model/homeScreenModel.dart';
import 'package:foodorder/app/modules/productListPage/view/productListView.dart';
import 'package:foodorder/app/modules/restaurantListPage/view/restaurantListView.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class SubCategoryListComponent extends StatefulWidget {
  SubCategoryListComponent(
      {super.key, required this.subcategoryData, required this.categoryList , required this.filterId} );
  SubCategoryListModel subcategoryData;
  List<HomeScreenCategoryModel>? categoryList;
var filterId ;
  @override
  State<SubCategoryListComponent> createState() =>
      _SubCategoryListComponentState();
}

class _SubCategoryListComponentState extends State<SubCategoryListComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsListView(
                  filterId:widget.filterId,
                    subcategoryData: widget.subcategoryData,
                    categoryList: widget.categoryList)));
      },
      child: Container(
        child: Column(
          children: [
            Container(
              // height: 100,
              // width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.greyBg,
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 105,
                  width: 105,
                  fit: BoxFit.contain,
                  imageUrl: widget.subcategoryData.image!,
                  placeholder: (context, url) => loaderList(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              //  Image.network(widget.categoryData!.image!),
            ),
            Text(capitalize(widget.subcategoryData.name) ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black))
          ],
        ),
      ),
    );
  }
}
