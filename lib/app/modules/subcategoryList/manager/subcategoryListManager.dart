import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';
import 'package:foodorder/app/modules/subcategoryList/remoteService/subcategoryListApi.dart';

class SubCategoryListManager {
  List<SubCategoryListModel> subcategoryList = [];
  List<SubCategoryListModel> filterSubcategoryList = [];
  String? subcategoryId = "";
  String? subcategoryName = "";
  var isLoading = true;
  getCategory({onRefresh, catId, needAppend = false}) async {
    isLoading = true;
    onRefresh();
    await SubCategoryListNetworkManager(dataManager: this).dataRepresent(
        needAppend: needAppend,
        onSuccess: () {
          isLoading = false;
          onRefresh();
        },
        onError: () {
          isLoading = false;
          onRefresh();
        },
        catId: catId);
  }
}
