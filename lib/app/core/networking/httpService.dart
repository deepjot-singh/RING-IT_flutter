import 'dart:async';
import 'dart:convert' as io;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dioLib;
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/costantHeader.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ResponseStatus {
  static const http412 = 412;
  static const http403 = 403;
  static const http422 = 422;
  static const http200 = 200;
  static const http418 = 418;
  static const http401 = 401;
  static const http204 = 204;
  static const http404 = 404;
  static const http500 = 500;
  static const httpTrue = true;
  static const httpFlase = false;
}

class HttpService {
//   Future<Map?> postServiceWithStream(
//       {required params,
//       required url,
//       isNeedFullScreenLoader = true,
//       isNeedErrorAlert = true}) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       showInternetAlert(
//           msg: ConstantText.msgInterNetLost,
//           title: ConstantText.titleInterNetLost);
//       return json;
//     }
//     var header = await tokenHeader();

//     if (isNeedFullScreenLoader) waitDialog();
//     print(header);
//     print(url);
//     print(params);
//     try {
//       var request = Request('POST', Uri.parse(url));
//       request.body = params;
//       // request.body = io.json.encode({
//       //   "match_id": "1",
//       //   "quarter": "1",
//       //   "play_result_id": "1",
//       //   "user_id": "3",
//       //   "tackled_by": "5",
//       //   "starting_pos": "32",
//       //   "end_pos": "-47"
//       // });
//       request.headers.addAll(header);

//       StreamedResponse response = await request.send();

//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       var responseString = await response.stream.bytesToString();
//       print(responseString);

//       Map<String, dynamic> json = io.json.decode(responseString);
//       print("postServiceWithStream $json ${json["status"]}");
//       if (json["status"] == ResponseStatus.http412 ||
//           json["status"] == ResponseStatus.http422) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         var isErrorKeyAvail = json.containsKey("errors");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             // if (isNeedErrorAlert) showAlert( message.toString());
//             return json;
//           } else {
//             if (isNeedErrorAlert)
//               // showAlert( ConstantText.msgSomethingWentWrong);
//           }
//         } else if (isErrorKeyAvail) {
//           var msg = "";
//           errors.forEach((k, v) {
//             msg = msg + v.toString();
//           });

//           // if (msg != "") {
//           //   if (isNeedErrorAlert) showAlert( msg);
//           // }
//         } else if (json["auth_code"] == 401) {
//           //SESSION EXPIRED;
//           sessionExpired(json);
//         } else {
//           return json;
//         }
//         return json;
//       } else {
//         sessionExpired(json);
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       print(e.toString());

//       // if (isNeedErrorAlert) showAlert(e.toString());
//       return json;
//     }
//   }

  Future<Map?> postServiceWithJsonParam(
      {required params,
      required url,
      isNeedFullScreenLoader = true,
      isNeedErrorAlert = true}) async {
    Map? json;
    if (await internetCheck() == false) {
      showInternetAlert(
          msg: ConstantText.msgInterNetLost,
          title: ConstantText.titleInterNetLost);
      return json;
    }
    var header = await tokenHeader();

    // if (isNeedFullScreenLoader) waitDialog();
    print(header);
    print(url);

    // try {
    var body = params;
    print(body);
    print(url);
    Response response = await post(Uri.parse(url), headers: header, body: body);
    print('RESUKLT ${response.body}');

    // if (isNeedFullScreenLoader) dismissWaitDialog();
    // Map<String, dynamic> json = io.jsonDecode(response.body);
    // print('RESUKLT ${response}');
    // if (json["status"] == ResponseStatus.http412) {
    //   var errors = json["errors"];
    //   var isMessageKeyAvail = errors.containsKey("message");
    //   if (isMessageKeyAvail) {
    //     var message = errors["message"];
    //     if (message != null) {
    //       if (isNeedErrorAlert) message.toString();
    //       return json;
    //     } else {
    //       if (isNeedErrorAlert)
    //         showAlert( ConstantText.msgSomethingWentWrong);
    //     }
    //   } else {
    //     return json;
    //   }
    // } else if (json["auth_code"] == 401) {
    //   //SESSION EXPIRED;

    //   // sessionExpired(json);
    // } else {
    //   return json;
    // }
    // } catch (e) {
    //   // if (isNeedFullScreenLoader) dismissWaitDialog();
    //   // print(e.toString());

    //   // if (isNeedErrorAlert) showAlert( e.toString());
    //   return json;
    // }
  }

//   Future<Map?> postPartsServiceWithUploadingProgress(
//       {required dioLib.FormData formData,
//       isNeedFullScreenLoader = true,
//       url = "",
//       onUploadProgress}) async {
//     Map? json;

//     if (await internetCheck() == false) {
//       showInternetAlert(
//           msg: ConstantText.msgInterNetLost,
//           title: ConstantText.titleInterNetLost);
//       return json;
//     }
//     var header = await tokenHeader();
//     var authToken = await LocalStore().getToken();
//     // GlobalVariable.uploadingProviderManager.percentage = 0.0;
//     // GlobalVariable.uploadingProviderManager.refresh();
//     // if (isNeedFullScreenLoader) waitProgressDialog();
//     print(header);
//     int byteCount = 0;
//     try {
//       final dioHttp = dioLib.Dio();
//       final response = await dioHttp.post(
//         '$url',
//         data: formData,
//         options: dioLib.Options(headers: header),
//         onReceiveProgress: (int sent, int total) {},
//         onSendProgress: (int sent, int total) {
//           double doubleValue = ((sent / total) * 100);
//           var value = doubleValue.toStringAsFixed(0);
//           print('progress: ${doubleValue} % ($sent/$total)');
//           // GlobalVariable.uploadingProviderManager.percentage = doubleValue;
//           // GlobalVariable.uploadingProviderManager.refresh();
//         },
//       );

//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       print(response.data);
//       Map<String, dynamic> json = response.data;

//       if (json["status"] == ResponseStatus.http412) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             showAlert( message.toString());
//           } else {
//             showAlert( ConstantText.msgSomethingWentWrong);
//           }
//         } else {
//           return json;
//         }
//       } else if (json["auth_code"] == ResponseStatus.http401) {
//         //SESSION EXPIRED;

//         var isMessageKeyAvail = json.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = json["message"];
//           if (message != null) {
//             // showAlert(
//             //     barrierDismissible: false,
//             //     msg: message.toString(),
//             //     onTap: () {
//             //       // Routes.gotoLoginScreen();
//             //     });
//           } else {
//             // showAlert(
//             //     barrierDismissible: false,
//             //     msg: ConstantText.sessionExpired,
//             //     onTap: () {
//             //       // Routes.gotoLoginScreen();
//             //     });
//           }
//         }
//       } else {
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       // showAlert( e.toString());
//       return json;
//     }
//   }

  Future<Map?> postPartsService(
      {required MultipartRequest request,
      isNeedFullScreenLoader = true}) async {
    print("jjjjj22");
    Map? json;
    if (await internetCheck() == false) {
      showInternetAlert(
          msg: ConstantText.msgInterNetLost,
          title: ConstantText.titleInterNetLost);
      return json;
    }
    var header = await tokenHeader();

    request.headers.addAll(header);
    if (isNeedFullScreenLoader) waitDialog();
    print(header);
    try {
      Response response = await Response.fromStream(await request.send());
      if (isNeedFullScreenLoader) dismissWaitDialog();
      Map<String, dynamic> json = jsonDecode(response.body);
      print(json);
      if (json["status"] == ResponseStatus.http412) {
        var errors = json["errors"];
        var isMessageKeyAvail = errors.containsKey("message");
        if (isMessageKeyAvail) {
          var message = errors["message"];
          if (message != null) {
            // showAlert(message.toString());
          } else {
            // showAlert( ConstantText.msgSomethingWentWrong);
          }
        } else {
          return json;
        }
      } else if (json["auth_code"] == ResponseStatus.http401) {
        //SESSION EXPIRED;

        var isMessageKeyAvail = json.containsKey("message");
        if (isMessageKeyAvail) {
          var message = json["message"];
          if (message != null) {
            // showAlert(
            //     barrierDismissible: false,
            //     msg: message.toString(),
            //     onTap: () {
            //       // Routes.gotoLoginScreen();
            //     });
          } else {
            // showAlert(
            //     barrierDismissible: false,
            //     msg: ConstantText.sessionExpired,
            //     onTap: () {
            //       // Routes.gotoLoginScreen();
            //     });
          }
        }
      } else {
        return json;
      }
    } catch (e) {
      if (isNeedFullScreenLoader) dismissWaitDialog();
      showAlert(e.toString());
      return json;
    }
  }

  Future<Map?> postService(
      {required params,
      required url,
      isNeedFullScreenLoader = true,
      isNeedErrorAlert = true}) async {
    Map? json;
    if (await internetCheck() == false) {
      showInternetAlert(
          msg: ConstantText.msgInterNetLost,
          title: ConstantText.titleInterNetLost);
      return json;
    }
    var header = await tokenHeader();
    if (isNeedFullScreenLoader) waitDialog();
    print(header);
    print(url);

    try {
      var body = io.json.encode(params);
      print(body);
      Response response =
          await post(Uri.parse(url), headers: header, body: body);
      if (isNeedFullScreenLoader) dismissWaitDialog();
      Map<String, dynamic> json = io.jsonDecode(response.body);
      if (json["status_code"] == ResponseStatus.http412) {
        var errors = json["errors"];
        var isMessageKeyAvail = errors.containsKey("message");
        if (isMessageKeyAvail) {
          var message = errors["message"];
          if (message != null) {
            if (isNeedErrorAlert) showAlert(message.toString());
            return json;
          } else {
            if (isNeedErrorAlert) showAlert(ConstantText.msgSomethingWentWrong);
            return json;
          }
        } else {
          return json;
        }
      } else if (json["auth_code"] == 401) {
        //SESSION EXPIRED;

        // sessionExpired(json);
      } else if (json["status"] == ResponseStatus.httpFlase) {
        return json;
      } else {
        return json;
      }
    } catch (e) {
      if (isNeedFullScreenLoader) dismissWaitDialog();
      print('exception error msg ${e.toString()}');
      //  showAlert(ConstantText.msgSomethingWentWrong);
      return json;
    }
  }

//   Future<Map?> postStatus(
//       {required params,
//       required url,
//       isNeedFullScreenLoader = true,
//       isNeedErrorAlert = true}) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       if (isNeedErrorAlert) {
//         showInternetAlert(
//             msg: ConstantText.msgInterNetLost,
//             title: ConstantText.titleInterNetLost);
//       }
//       return json;
//     }

//     var header = await tokenHeader();

//     if (isNeedFullScreenLoader) waitDialog();
//     print(header);
//     print(url);

//     try {
//       var body = io.json.encode(params);
//       print(body);
//       Response response =
//           await post(Uri.parse(url), headers: header, body: body);
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       Map<String, dynamic> json = io.jsonDecode(response.body);
//       print(json);
//       if (json["status"] == ResponseStatus.http412) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             if (isNeedErrorAlert) showAlert(message.toString());
//             return json;
//           } else {
//             if (isNeedErrorAlert)
//               // showAlert( ConstantText.msgSomethingWentWrong);
//           }
//         } else {
//           return json;
//         }
//       } else if (json["auth_code"] == 401) {
//         //SESSION EXPIRED;

//         sessionExpired(json);
//       } else {
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       print(e.toString());

//       // if (isNeedErrorAlert) showAlert( e.toString());
//       return json;
//     }
//   }

//   Future<Map?> postServiceNoAlertDecision(
//       {required params,
//       required url,
//       isNeedFullScreenLoader = true,
//       isNeedErrorAlert = true}) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       if (isNeedErrorAlert) {
//         showInternetAlert(
//             msg: ConstantText.msgInterNetLost,
//             title: ConstantText.titleInterNetLost);
//       }
//       return json;
//     }
//     var header = await tokenHeader();

//     if (isNeedFullScreenLoader) waitDialog();
//     print(header);
//     print(url);

//     try {
//       var body = io.json.encode(params);
//       print(body);
//       Response response =
//           await post(Uri.parse(url), headers: header, body: body);
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       Map<String, dynamic> json = io.jsonDecode(response.body);
//       print(json);
//       if (json["status"] == ResponseStatus.http412) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             if (isNeedErrorAlert) showAlert( message.toString());
//             return json;
//           } else {
//             if (isNeedErrorAlert)
//               // showAlert( ConstantText.msgSomethingWentWrong);
//           }
//         } else {
//           return json;
//         }
//       } else if (json["auth_code"] == 401) {
//         //SESSION EXPIRED;

//         sessionExpired(json);
//       } else {
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       print(e.toString());

//       if (isNeedErrorAlert) showAlert( e.toString());
//       return json;
//     }
//   }

  Future<Map?> getService({required url, isNeedFullScreenLoader = true}) async {
    print('ishit');
    Map? json;
    if (await internetCheck() == false) {
      showInternetAlert(
          msg: ConstantText.msgInterNetLost,
          title: ConstantText.titleInterNetLost);
      return json;
    }
    var header = await tokenHeader();

    if (isNeedFullScreenLoader) waitDialog();
    print('get request url $url');
    try {
      Response response = await get(Uri.parse(url), headers: header);
      if (isNeedFullScreenLoader) dismissWaitDialog();
      Map<String, dynamic> json = io.jsonDecode(response.body);
      print('===json===$json');

      if (json["status"] == ResponseStatus.http422) {
        var errors = json["errors"];
        var isMessageKeyAvail = errors.containsKey("message");
        if (isMessageKeyAvail) {
          var message = errors["message"];
          if (message != null) {
            // showAlert(msg: message.toString());
          } else {
            // showAlert(msg: ConstantText.msgSomethingWentWrong);
          }
        } else {
          // showAlert(msg: ConstantText.msgSomethingWentWrong);
        }
      } else if (json["auth_code"] == ResponseStatus.http401) {
        //SESSION EXPIRED;

        // sessionExpired(json);
      } else {
        print("STEP 1");
        return json;
      }
    } catch (e) {
      if (isNeedFullScreenLoader) dismissWaitDialog();
      print(e.toString());
      // showAlert(msg: e.toString());
      return json;
    }
  }

//   Future<Map?> getServiceWithNoAlert({
//     required url,
//   }) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       return json;
//     }
//     var header = await tokenHeader();

//     print(url);
//     try {
//       Response response = await get(Uri.parse(url), headers: header);

//       Map<String, dynamic> json = io.jsonDecode(response.body);
//       print(json);

//       if (json["status"] == 422) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//         } else {
//           //showAlert(msg: C
//           // return json;onstantText.msgSomethingWentWrong);
//         }
//         return json;
//       } else if (json["auth_code"] == 401) {
//         return json;
//       } else {
//         return json;
//       }
//     } catch (e) {
//       print(e.toString());

//       return json;
//     }
//   }

//   sessionExpired(json) {
//     print("SESSION EXPIRED");
//     var isMessageKeyAvail = json.containsKey("message");
//     if (isMessageKeyAvail) {
//       var message = json["message"];
//       if (message != null) {
//         showAlert(
//             msg: message.toString(),
//             onTap: () {
//               // Routes.gotoLoginScreen();
//             });
//       } else {
//         showAlert(
//             msg: ConstantText.sessionExpired,
//             onTap: () {
//               // Routes.gotoLoginScreen();
//             });
//       }
//     }
//   }

//   Future<Map?> deleteService(
//       {required url, isNeedFullScreenLoader = true}) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       showInternetAlert(
//           msg: ConstantText.msgInterNetLost,
//           title: ConstantText.titleInterNetLost);
//       return json;
//     }
//     var header = await tokenHeader();

//     if (isNeedFullScreenLoader) waitDialog();
//     try {
//       Response response = await delete(Uri.parse(url), headers: header);
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       Map<String, dynamic> json = io.jsonDecode(response.body);
//       print(json);

//       if (json["status"] == 422) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             showAlert(msg: message.toString());
//           } else {
//             showAlert(msg: ConstantText.msgSomethingWentWrong);
//           }
//         } else {
//           showAlert(msg: ConstantText.msgSomethingWentWrong);
//         }
//       } else if (json["auth_code"] == 401) {
//         //SESSION EXPIRED;

//         var isMessageKeyAvail = json.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = json["message"];
//           if (message != null) {
//             showAlert(
//                 msg: message.toString(),
//                 onTap: () {
//                   // Routes.gotoLoginScreen();
//                 });
//           } else {
//             showAlert(
//                 msg: ConstantText.sessionExpired,
//                 onTap: () {
//                   // Routes.gotoLoginScreen();
//                 });
//           }
//         }
//       } else {
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       showAlert(msg: e.toString());
//       return json;
//     }
//   }

//   Future<Map?> deleteServiceWithoutAlert(
//       {required url, isNeedFullScreenLoader = true, needAlert = true}) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       showInternetAlert(
//           msg: ConstantText.msgInterNetLost,
//           title: ConstantText.titleInterNetLost);
//       return json;
//     }
//     var header = await tokenHeader();

//     if (isNeedFullScreenLoader) waitDialog();
//     try {
//       print(url);
//       Response response = await delete(Uri.parse(url), headers: header);
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       Map<String, dynamic> json = io.jsonDecode(response.body);
//       print(json);

//       if (json["status"] == 422) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             if (needAlert) showAlert(msg: message.toString());
//           } else {
//             if (needAlert) showAlert(msg: ConstantText.msgSomethingWentWrong);
//           }
//         } else {
//           if (needAlert) showAlert(msg: ConstantText.msgSomethingWentWrong);
//         }
//         return json;
//       } else if (json["auth_code"] == 401) {
//         //SESSION EXPIRED;

//         var isMessageKeyAvail = json.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = json["message"];
//           if (message != null) {
//             if (needAlert) {
//               showAlert(
//                   msg: message.toString(),
//                   onTap: () {
//                     // Routes.gotoLoginScreen();
//                   });
//             }
//           } else {
//             if (needAlert) {
//               showAlert(
//                   msg: ConstantText.sessionExpired,
//                   onTap: () {
//                     // Routes.gotoLoginScreen();
//                   });
//             }
//           }
//         }
//         return json;
//       } else {
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       if (needAlert) showAlert(msg: e.toString());
//       print(e.toString());
//       return json;
//     }
//   }

//   downloadPDFFile(
//       {String fileName = "",
//       required url,
//       isNeedFullScreenLoader = true,
//       needAlert = true}) async {
//     PermissionStatus _permissionStatus = await Permission.storage.request();
//     PermissionStatus _permissionExternalStatus =
//         await Permission.manageExternalStorage.request();
//     PermissionStatus _permissionNewStatus = await Permission.photos.request();

//     Directory? directory;
//     var savePath = "";
//     if (_permissionStatus == PermissionStatus.granted ||
//         _permissionExternalStatus == PermissionStatus.granted ||
//         _permissionNewStatus == PermissionStatus.granted) {
//       if (Platform.isIOS) {
//         directory = await getApplicationDocumentsDirectory();
//         savePath = directory.path;
//       } else {
//         directory = await getDownloadsDirectory();
//         if (directory != null) {
//           savePath = directory.path;
//         } else {
//           directory = await getExternalStorageDirectory();
//           if (directory != null) {
//             savePath = directory.path;
//           }
//         }
//         //ExternalPath.getExternalStoragePublicDirectory(
//         //  ExternalPath.DIRECTORY_DOWNLOADS);
//       }

//       print("URl:$url");
//       try {
//         final response = await get(Uri.parse(url));
//         Map<String, dynamic> json = io.jsonDecode(response.body);
//         if (json["status"] == 200) {
//           var bytes = base64Decode(json["data"].toString());
//           print("esponse.statusCode:${response.statusCode}");
//           var name =
//               '$savePath/${DateTime.now().microsecondsSinceEpoch}${fileName}.pdf';
//           File file = await File(name).create(recursive: true);
//           print("file:${file.path}");
//           await file.writeAsBytes(bytes);
//           if (Platform.isIOS) {
//             // ToastHelper.showToast(msg: "Downloaded -> ${"file_folder"}");
//           } else {
//             // ToastHelper.showToast(msg: "${"downloaded"}\n$name");
//           }
//           // OpenResult canOpen = await OpenFile.open(file.path);
//         } else {}
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       if (Platform.isAndroid) {
//         showAlertWithConfirmButton(
//             msg: "This app needs Storage access permission to download file.",
//             positiveBtnTitle: "Grant",
//             negativeBtnTitle: "Cancel",
//             onTap: () async {
//               //Permission
//               downloadPDFFile(url: url, fileName: fileName);
//             });
//       }
//       //  showAlert(msg: "Cannot Download File, You have not granted permission");
//     }
//   }

//   Future<Map?> downloadPDFService(
//       {required params,
//       required url,
//       isNeedFullScreenLoader = true,
//       isNeedErrorAlert = true}) async {
//     Map? json;
//     if (await internetCheck() == false) {
//       showInternetAlert(
//           msg: ConstantText.msgInterNetLost,
//           title: ConstantText.titleInterNetLost);
//       return json;
//     }
//     var header = await tokenHeader();
//     if (isNeedFullScreenLoader) waitDialog();
//     print(header);
//     print(url);

//     try {
//       var body = io.json.encode(params);
//       print(body);
//       Response response =
//           await post(Uri.parse(url), headers: header, body: body);
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       Map<String, dynamic> json = io.jsonDecode(response.body);
//       print(json);
//       if (json["status"] == ResponseStatus.http412) {
//         var errors = json["errors"];
//         var isMessageKeyAvail = errors.containsKey("message");
//         if (isMessageKeyAvail) {
//           var message = errors["message"];
//           if (message != null) {
//             if (isNeedErrorAlert) showAlert(msg: message.toString());
//             return json;
//           } else {
//             if (isNeedErrorAlert)
//               showAlert(msg: ConstantText.msgSomethingWentWrong);
//             return json;
//           }
//         } else {
//           return json;
//         }
//       } else if (json["auth_code"] == 401) {
//         //SESSION EXPIRED;

//         sessionExpired(json);
//       } else {
//         return json;
//       }
//     } catch (e) {
//       if (isNeedFullScreenLoader) dismissWaitDialog();
//       print(e.toString());

//       if (isNeedErrorAlert) showAlert(msg: e.toString());
//       return json;
//     }
//   }
}
