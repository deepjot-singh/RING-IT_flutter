import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class NetworkImage extends StatelessWidget {
  String? imgURL = "";
  bool isUserType = false;
  NetworkImage({this.imgURL, this.isUserType = false});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imgURL!,
        placeholder: (context, url) => Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.redThemeColor),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: !isUserType
              ? simpleMessageShow("Unable load image")
              : Image(
                  image: !isUserType
                      ? AssetImage("assets/images/icon-splash.png")
                      : AssetImage("assets/images/avatar.png"),
                  fit: BoxFit.cover),
        ),
      ),
    );
  }
}
