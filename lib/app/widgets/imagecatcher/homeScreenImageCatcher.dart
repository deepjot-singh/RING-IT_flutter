import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class HomeScreenImageCatcher extends StatelessWidget {
  String? imgURL = "";
  bool isUserType = false;
  HomeScreenImageCatcher({this.imgURL, this.isUserType = false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      // fit: BoxFit.cover,
      imageUrl: imgURL!,
      fit: BoxFit.fill,

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
    );
  }
}

class HomeImageCatcher extends StatelessWidget {
  String? imgURL = "";
  bool isUserType = false;
  HomeImageCatcher({this.imgURL, this.isUserType = false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imgURL!,

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
    );
  }
}
