import 'package:flutter/material.dart';
import 'package:foodorder/app/core/DateTimeFormat/dateTimeFormat.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/modules/notificationPage/manager/notificationListManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';

class NotificationPageView extends StatefulWidget {
  const NotificationPageView({super.key});

  @override
  State<NotificationPageView> createState() => _NotificationPageViewState();
}

class _NotificationPageViewState extends State<NotificationPageView> {
  var manager = NotificationListManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getNotificationListData();
    });
  }

  getNotificationListData() async {
    await manager.getNotificationList(onRefresh: () {
      setState(() {});
      print("object");
    });
    setState(() {});
    print('Notifications data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(
        title: ConstantText.notificationPageTitle,
        needBackIcon: false,
      ),
      backgroundColor: Colors.white,
      body: 
      // manager.isLoading ? loaderList() :
      SafeArea(
        child :
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: manager.notificationList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(top: 10, left: 7, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      backgroundColor:
                                          Color.fromRGBO(217, 217, 217, 1),
                                      child: Icon(
                                          Icons.notifications_none_outlined)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        manager.notificationList[index].message
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontFamily: 'NunitoSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ),
                                  )
              ])])
                              );
                            }),
                      )
                    ]),
              ),
            ),
    );
  }
}
