library responsive_sizer;

import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/toastHelper/toastHelper.dart';
import 'package:foodorder/app/widgets/customBtn/customBtn.dart';

simpleMessageShow(String msg) {
  return Center(
    child: Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    ),
  );
}


Widget layerIcon(count) {
  return IntrinsicWidth(
    child: Container(
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image.asset(
                "assets/icons/attachment.png",
                color: AppColor.theme,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              " $count",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ),
      ),
    ),
  );
}

headerAlert({headerTitle = "Link Photos"}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Container(
      //   color: Colors.black,
      //   width: Device.orientation == Orientation.portrait ? 6.h : 6.w,
      //   height: Device.orientation == Orientation.portrait ? 6.h : 6.w,
      //   child: Padding(
      //     padding: const EdgeInsets.only(right: 10, left: 5),
      //     child: Image.asset(
      //       "assets/icons/kb3_transparent_logo.png",
      //       // width: 80,
      //       fit: BoxFit.contain,
      //     ),
      //   ),
      // ),
      Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          headerTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.textAlertHeading),
        ),
      ),
      // Container(
      //   color: Colors.transparent,
      //   width: Device.orientation == Orientation.portrait ? 6.h : 6.w,
      //   height: Device.orientation == Orientation.portrait ? 6.h : 6.w,
      //   child: Padding(
      //       padding: const EdgeInsets.only(right: 10, left: 5),
      //       child: Container()),
      // ),
    ],
  );
}

// void showAlert(
//     {required msg,
//     onTap,
//     btnTitle = "",
//     headerTitle = "Link Photos",
//     doublepop = false,
//     BuildContext? context,
//     bool barrierDismissible = false}) {
//   print("jjhkh̤");
//   showDialog(
//       barrierDismissible: barrierDismissible,
//       context: context!,
//       //GlobalVariable.getRootContext(),
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, setState) {
//           print("jjhkh̤22");
//           return Dialog(
//             backgroundColor: Colors.white,
//             clipBehavior: Clip.antiAlias,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
//             // insetPadding: EdgeInsets.fromLTRB(25, 0.0, 25.0, 0.0),
//             // title: Text('Select Services'),
//             // contentPadding: EdgeInsets.only(top: 12.0),
//             child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                     maxWidth: 60, minWidth: 60, maxHeight: 60, minHeight: 20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // headerAlert(headerTitle: headerTitle),
//                       SizedBox(
//                         width: 2,
//                         height: 2,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 2,
//                         ),
//                         child: Text(
//                           msg,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: AppColor.textAlertText),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 2,
//                         height: 2,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Spacer(),
//                           Container(
//                             child: CustomButton.regular(
//                               title: btnTitle != "" ? btnTitle : "Dismiss",
//                               radius: 8,
//                               fontSize: 15.5,
//                               onTap: () {
//                                 if (doublepop == true) {
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context).pop();
//                                 } else {
//                                   Navigator.of(context).pop();
//                                   if (onTap != null) {
//                                     onTap();
//                                   }
//                                 }
//                               },
//                             ),
//                           ),
//                           Spacer(),
//                           // SizedBox(
//                           //   width: Device.orientation == Orientation.portrait
//                           //       ? 2.h
//                           //       : 2.w,
//                           // ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 2,
//                         height: 2,
//                       ),
//                     ],
//                   ),
//                 )),
//           );
//         });
//       });
// }
showAlert(
  msg, {
  BuildContext? context,
  bool pop = false,
  VoidCallback? onTap,
  barrierDismiss = false,
  bool DoublePopNeeded = false,
  bool triplePopNeeded = false,
  String btnName = "OK",
}) {
  var alert = AlertDialog(
    title: Container(
      // height: 80,
      width: 250,
      child: Column(
        children: <Widget>[
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              msg,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackstd),
            ),
          )
        ],
      ),
    ),
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(28)),
    actions: <Widget>[
      Center(
        child: CustomButton.regular(
          background: AppColor.redThemeColor,
          title: btnName,
          width: 70,
          height: 30,
          fontSize: 16,
          fontweight: FontWeight.w700,
          radius: 10,
          onTap: () {
            // Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
            //     .pop();
            if (DoublePopNeeded == true) {
              Navigator.of(GlobalVariable.getRootContext()).pop();
              Navigator.of(GlobalVariable.getRootContext()).pop();

              //   Navigator.of(GlobalVariable.getRootContext()).pop();
              // Navigator.of(Constant.navigatorKey.currentState!.overlay!.context)
              //     .pop();
            } else if (triplePopNeeded == true) {
              Navigator.of(GlobalVariable.getRootContext()).pop();
              Navigator.of(GlobalVariable.getRootContext()).pop();
              Navigator.of(GlobalVariable.getRootContext()).pop();
            }

            if (onTap != null) {
              onTap();
            } else {
              Navigator.of(GlobalVariable.getRootContext()).pop();
            }
          },
        ),
      ),
    ],
  );

  showDialog(
      barrierDismissible: false, //barrierDismiss,
      context: GlobalVariable.getRootContext(),
      //Constant.navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return alert;
      });
}

mixin Constant {}

void showInternetAlert({required msg, required title}) {
  ToastHelper.showToast(msg: msg);
  //showAlert(msg);
}

void showAlertWithConfirmButton(
    {required msg,
    positiveBtnTitle = "Yes",
    negativeBtnTitle = "No",
    negativeBtnOnTap,
    required onTap}) {
  showDialog(
      context: GlobalVariable.getRootContext(),
      builder: (BuildContext context) {
        // positiveBtnTitle = "Yes";
        // negativeBtnTitle = "No";
        return StatefulBuilder(builder: (contextt, setState) {
          return Dialog(
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
              height: 120,
              width: 250,
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: 150,
                      minWidth: 100,
                      maxHeight: 90,
                      minHeight: 90),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // headerAlert(),
                        SizedBox(
                          width: 2,
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                          child: Text(
                            msg,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColor.textAlertText),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Spacer(),
                            SizedBox(
                              width: 5,
                            ),

                            CustomButton.regular(
                              titleColor: Colors.white,
                              title: positiveBtnTitle,
                              radius: 8,
                              fontSize: 15.5,
                              height: 40,
                              width: 60,
                              background: AppColor.redThemeColor,
                              onTap: () {
                                Navigator.of(context).pop();
                                onTap();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton.regular(
                              title: negativeBtnTitle,

                              // height: Device.orientation == Orientation.portrait
                              //     ? 4.h
                              //     : 4.w,
                              // width: Device.orientation == Orientation.portrait
                              //     ? 25.w
                              //     : 25.h,
                              // fontSize: 15.sp,

                              background: Colors.red,
                              radius: 8,
                              height: 40,
                              width: 60,
                              fontSize: 15.5,
                              fontweight: FontWeight.w500,
                              titleColor: Colors.white,
                              onTap: () {
                                Navigator.of(context).pop();
                                if (negativeBtnOnTap != null) {
                                  negativeBtnOnTap();
                                }
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 2,
                          height: 2,
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
      });
}

headerDismissButtonView(
    {title = "", required onTap, Color textColor = Colors.black}) {
  return Container(
      width: 100,
      //color: AppColor.theme,
      height: 4,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 30),
              //   child: InkWell(onTap: () {}, child: Container()),
              // ),
              // Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              //   Spacer(),
            ],
          ),
          Positioned(
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 1),
              child: InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: AppColor.blackstd,
                  )),
            ),
          )
        ],
      ));
}

loader() {
  return Container(
    width: 8,
    height: 8,
    child: const CircularProgressIndicator(
      strokeWidth: 1.5,
      valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
    ),
  );
}

Future<void> showLoginDialog() async {
  return showDialog(
    barrierDismissible: true,
    context: GlobalVariable.getRootContext(),
    builder: (context) {
      return AlertDialog(
          clipBehavior: Clip.antiAlias,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          insetPadding: EdgeInsets.zero,
          //backgroundColor: Colors.transpa

          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 85,
                    minWidth: 85,
                    maxHeight: 100,
                    minHeight: 1,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.bgColor,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "You must login to perform this action.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton.regular(
                                    titleColor: Colors.white,
                                    title: "Login",

                                    radius: 8,
                                    fontSize: 15.5,

                                    // height: Device.orientation == Orientation.portrait
                                    //     ? 4.h
                                    //     : 4.w,
                                    // width: Device.orientation == Orientation.portrait
                                    //     ? 25.w
                                    //     : 25.h,
                                    // fontSize: 15.sp,
                                    background: AppColor.theme,
                                    onTap: () {
                                      // Routes.gotoLogin(
                                      //     GlobalVariable.getRootContext());
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: CustomButton.regular(
                                    title: "Later",

                                    // height: Device.orientation == Orientation.portrait
                                    //     ? 4.h
                                    //     : 4.w,
                                    // width: Device.orientation == Orientation.portrait
                                    //     ? 25.w
                                    //     : 25.h,
                                    // fontSize: 15.sp,

                                    background: Colors.transparent,
                                    radius: 8,
                                    fontSize: 15.5,
                                    fontweight: FontWeight.w700,
                                    borderWidth: 1,

                                    titleColor: AppColor.pureWhite,

                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ]);
    },
  );
}
