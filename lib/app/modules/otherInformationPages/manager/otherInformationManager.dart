import 'package:foodorder/app/modules/otherInformationPages/remoteService/otherInformationApi.dart';

class OtherInformationManager {
  var contentData = "";
  String heading = "";

  getOtherInformationContent({required onRefresh, required type, required context}) {
    var apiManager = OtherInformationApi(dataManager: this);
    apiManager.getContent(
        context: context,
        type: type,
        onSuccess: (content, title) {
          contentData = content;
          heading = title;
          print("content3- ${content}");
          print("title3- ${content}");
          onRefresh();
        });
  }
}
