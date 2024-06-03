import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/settingPage/manager/notificationSettingsManager.dart';

class notificationSettingComponent extends StatefulWidget {
  notificationSettingComponent({super.key, this.is_noti, this.is_email});
  bool? is_noti;
  bool? is_email;
  @override
  State<notificationSettingComponent> createState() =>
      _notificationSettingComponentState();
}

class _notificationSettingComponentState
    extends State<notificationSettingComponent> {
  var manager = NotificationSettingsManager();
  var toggleChanged;
  var notificationToggle;
  var emailToggle;
  bool _is_notification_enable = true;
  bool _is_email_enable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("---------");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //await setNotifactionData();
      print('toggle btn ');
      getToggleStatus();
    });
  }

  setNotifactionData() async {
    _is_notification_enable =
        await LocalStore().getNotificationSelection() as bool;
    if (_is_notification_enable == 0) {
      print("${_is_notification_enable}");
    }
  }

  getToggleStatus() async {
    await manager.NotificationStatus(onSuccess: () {
      setState(() {});
    });

    print('data11a-${manager.email}');
  }

//get list of restaurants
  getData() async {
    await manager.updateNotification(type: toggleChanged);
    setState(() {});
    print('dataa');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/icons/iconLetter.png",
            //   height: 20,
            //   width: 20,
            // ),
            const Text(
              ConstantText.notification,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Container(
              height: 20,
              child: Transform.scale(
                scale: .7,
                child: Switch(
                  value: manager.notification == "0" ? false : true,
                  //value:  widget.is_noti ?? false,
                  onChanged: (value) {
                    setState(() {
                      manager.notification = value ? "1" : "0";
                      // _is_notification_enable = value;
                      toggleChanged = "notification";

                      manager.updateNotification(type: 'notification');
                      // print("Notification Toggle $notificationToggle");
                    });
                  },
                  activeTrackColor: AppColor.togglebtn,
                  activeColor: Colors.white,
                  inactiveThumbColor: AppColor.togglebtn,
                  inactiveTrackColor: AppColor.pureWhite,
                  trackOutlineWidth: MaterialStatePropertyAll(0.5),
                ),
              ),
            ),
          ],
        ),
        Visibility(
           visible: false,
          child:  SizedBox(
            height: 15,
          ),
        ),
        Visibility(
          visible: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   "assets/icons/iconLetter.png",
              //   height: 20,
              //   width: 20,
              // ),
              Text(
                ConstantText.email,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Container(
                height: 20,
                child: Transform.scale(
                  scale: .7,
                  child: Switch(
                    // value:  widget.is_email ?? false,
                    value: manager.email == "0" ? false : true,
                    //_is_email_enable,
                    onChanged: (value) {
                      setState(() {
                        manager.email = value ? "1" : "0";
                        //  _is_email_enable = value;
                        toggleChanged = "notification";
                        print("object");
                        manager.updateNotification(type: 'email');
          
                        print("Email Toggle $emailToggle");
                      });
                    },
                    activeTrackColor: AppColor.togglebtn,
                    activeColor: Colors.white,
                    inactiveThumbColor: AppColor.togglebtn,
                    inactiveTrackColor: AppColor.pureWhite,
                    trackOutlineWidth: MaterialStatePropertyAll(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
