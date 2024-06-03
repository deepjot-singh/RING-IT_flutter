
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';

dismissWaitDialog() {
  var context = GlobalVariable.getRootContext();

  if (GlobalVariable.isRunningLoader) {
    GlobalVariable.isRunningLoader = false;
    Navigator.of(context).pop();
  }
}

waitDialog({message = "   Please wait...", Duration? duration}) {
     print("hjgjkhkjhkln");
  var context = GlobalVariable.getRootContext();

  GlobalVariable.isRunningLoader = true;
  var dialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    elevation: 0.0,
    backgroundColor:
        Colors.transparent, //Theme.of(context).dialogBackgroundColor,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            clipBehavior: Clip.antiAlias,
            width:  60,
            height:  60,
            decoration: new BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    // margin: EdgeInsets.all(10),
                    child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 5,
                      color: AppColor.pureWhite,
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ))),
          ),

          // Text(message),
        ],
      ),
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(onWillPop: () async => false, child: dialog),
  );

  if (duration != null) {
    Future.delayed(
      duration,
      () {
        Navigator.of(context).pop();
      },
    );
  }
}

// waitProgressDialog({message = "   Uploading...", Duration? duration}) {
//   var context = GlobalVariable.getRootContext();

//   GlobalVariable.isRunningLoader = true;
//   var dialog = Dialog(
//     elevation: 0.0,
//     insetPadding: EdgeInsets.zero,
//     backgroundColor:
//         Colors.transparent, //Theme.of(context).dialogBackgroundColor,
//     child:
//         Consumer<UploadingProviderManager>(builder: (context, object, child) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             // clipBehavior: Clip.antiAlias,
//             width: Device.orientation == Orientation.portrait ? 90.w : 90.w,
//             height: Device.orientation == Orientation.portrait ? 15.h : 15.w,
//             decoration: new BoxDecoration(
//               color: Colors.black,
//             ),
//             child: Container(
//                 // margin: EdgeInsets.all(10),
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                 Text(
//                   "${message}",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 17.sp,
//                       fontWeight: FontWeight.w800),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                 Padding(
//                   padding: DeviceUtil.isTablet
//                       ? Device.orientation == Orientation.portrait
//                           ? EdgeInsets.symmetric(horizontal: 5.w)
//                           : EdgeInsets.symmetric(horizontal: 5.h)
//                       : EdgeInsets.symmetric(horizontal: 5.w),
//                   child: LinearProgressIndicator(
//                     value: object.percentage,
//                     minHeight: DeviceUtil.isTablet ? 15 : 10,
//                     backgroundColor: Colors.grey.shade300,
//                     // valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
//                     color: Colors.green,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 0.5.h,
//                 ),
//                 Text(
//                   "${object.percentage.toInt()}%",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//               ],
//             )),
//           ),

//           // Text(message),
//         ],
//       );
//     }),
//   );

//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (_) => WillPopScope(onWillPop: () async => false, child: dialog),
//   );

//   if (duration != null) {
//     Future.delayed(
//       duration,
//       () {
//         Navigator.of(context).pop();
//       },
//     );
//   }
// }
