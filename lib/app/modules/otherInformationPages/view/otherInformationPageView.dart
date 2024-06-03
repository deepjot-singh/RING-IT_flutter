import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/modules/otherInformationPages/manager/otherInformationManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';

class OtherInformationPageView extends StatefulWidget {
  OtherInformationPageView({super.key, required this.type});
  String type;

  @override
  State<OtherInformationPageView> createState() =>
      _OtherInformationPageViewState();
}

class _OtherInformationPageViewState extends State<OtherInformationPageView> {
  var manager = OtherInformationManager();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.type);
  }

  getData(type) {
    manager.getOtherInformationContent(
      type: type,
      context: context,
      onRefresh: () {
        setState(() {
          print("content----${manager.heading}");
          print("content----${manager.contentData}");
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(
        title: manager.heading,
        needBackIcon: false,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: (manager.contentData == "")
            ? Center(child: loaderList())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HtmlWidget(
                    manager.contentData,
                  ),
                ),
              ),
      ),
    );
  }
}
