import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constantURLs/constantUrls.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/networking/httpService.dart';
import 'package:foodorder/app/modules/subcategoryList/manager/subcategoryListManager.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/appBar/searchAppBar2.dart';

class SubCategoryListNetworkManager {
  var api = HttpService();
  SubCategoryListManager dataManager;
  SubCategoryListNetworkManager({
    required this.dataManager,
  });

  dataRepresent({onSuccess, onError, catId, needAppend = false}) async {
    print("llllkkk-${catId}");
    try {
      var finalUrl = ConstantUrls.wsGetSubCategory + catId;
      Map<dynamic, dynamic>? jsonResponse =
          await api.getService(url: finalUrl, isNeedFullScreenLoader: false);
      print('userAddressData==== $jsonResponse');
      if (jsonResponse != null) {
        if (jsonResponse["status_code"] == ResponseStatus.http412 ||
            jsonResponse["status_code"] == ResponseStatus.http422) {
          var errors = jsonResponse["errors"];
          var isMessageKeyAvail = errors.containsKey("message");
          if (isMessageKeyAvail) {
            // showAlert(msg: errors["message"].toString());
          }
          onError();
        } else if (jsonResponse["status_code"] == ResponseStatus.http500) {
          print("Something went wrong ......");
          showAlert(ConstantText.somethingWentWrong);
        } else if (jsonResponse["status_code"] == ResponseStatus.http200) {
          print("Sucesssssss......");
          var data = jsonResponse["data"];
          if (data != null) {
            var list = data as List;
            List<SubCategoryListModel> dataList =
                list.map((e) => SubCategoryListModel.fromJson(e)).toList();
            dataManager.filterSubcategoryList.addAll(dataList);
            if (needAppend) dataManager.subcategoryList.addAll(dataList);
          }
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          var isMessageKeyAvail = jsonResponse.containsKey("message");
          if (isMessageKeyAvail) {
            var errorMsg = jsonResponse["message"].toString();
            if (errorMsg != "") {
              // showAlert(msg: errorMsg);
            }
          }
          onError();
        }
      } else {
        onError();
      }
    } catch (e) {
      ConstantText.somethingWentWrong;
    }
  }
}
