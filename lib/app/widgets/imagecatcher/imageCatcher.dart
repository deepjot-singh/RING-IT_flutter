import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class ImageCatcher extends StatelessWidget {
  String? imgURL = "";
  bool isUserType = false;
  ImageCatcher({this.imgURL, this.isUserType = false,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,
      width: 250,
      //clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13), topRight: Radius.circular(13))),
      child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        child: CachedNetworkImage(
         
          // fit: BoxFit.cover,
          imageUrl: imgURL!,
          fit: BoxFit.cover,
        
          placeholder: (context, url) => loaderList(),
          // errorWidget: (context, url, error) => Icon(Icons.error),
          // height: 137,
          // width: 137,
          //  ),
          ///  ),
          errorWidget: (context, url, error) => Center(
            child: !isUserType
                ? showAlert("Unable load image")
                : Image(
                    image: !isUserType
                        ? AssetImage("assets/images/icon-splash.png")
                        : AssetImage("assets/images/avatar.png"),
                    fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
