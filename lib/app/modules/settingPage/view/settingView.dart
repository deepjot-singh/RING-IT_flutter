import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/loader/loaders.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/addressBookPage/view/addressBookView.dart';
import 'package:foodorder/app/modules/changePasswordForm/view/changePasswordView.dart';
import 'package:foodorder/app/modules/deleteAccountPage/manager/deleteAccountManager.dart';
import 'package:foodorder/app/modules/deleteAccountPage/view/deleteAccountView.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/orderHistoryPage/view/orderHistoryView.dart';
import 'package:foodorder/app/modules/otherInformationPages/view/otherInformationPageView.dart';
import 'package:foodorder/app/modules/profile/manager/profileManager.dart';
import 'package:foodorder/app/modules/profile/provider/profileProvider.dart';
import 'package:foodorder/app/modules/settingPage/component/settingPageComponent.dart';
import 'package:foodorder/app/modules/settingPage/component/notificationSettingComponent.dart';
import 'package:foodorder/app/modules/profile/view/profileView.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:provider/provider.dart';

class SettingPageView extends StatefulWidget {
  const SettingPageView({super.key});

  @override
  State<SettingPageView> createState() => SettingPageViewState();
}

class SettingPageViewState extends State<SettingPageView> {
  var token = null;

  var manager = DeleteAccountManager();
  var profilemanager = ProfileManager();
  var provider = ProfileProvider();

  @override
  void initState() {
    super.initState();
    provider = GlobalVariable.ProfileProviderManager;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      profilemanager = provider.manager;
      token = await LocalStore().getToken();

      getProfileData();
      getNotificationState();

      print("token -- ${token.toString()}");
    });
  }

  getNotificationState() {
    setState(() {
      token;
    });
  }

  getProfileData() {
    provider.profileDataRepresent();
    // await manager.validation(onRefresh: (){
    //   setState(() {

    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(
        title: ConstantText.profile,
      ),
      body: SettingsBody(),
    );
  }

  SettingsBody() {
    // print('check for token ${token}');
    // print('pvdr.profileDataList?.imgsrc, ${pvdr.profileDataList?.name}');
    // print('pvdr.profileDataList?.imgsrc, ${pvdr.profileDataList?.imgsrc}');
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<ProfileProvider>(builder: (context, object, child) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 20),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                    color: Color.fromRGBO(239, 239, 239, 1),
                  ),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.grey[150],
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              imageUrl:
                                  // provider.manager.profileDataList.imgsrc ,
                                  profilemanager.profileDataList?.imgsrc ?? "",
                              placeholder: (context, url) => loaderList(),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/profileImage.png",
                                height: 80,
                              ),
                            ),
                          ),
                        )),
                    //   if (profilemanager.profileDataList != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalize(profilemanager.profileDataList?.name
                                    .toString() ??
                                "Guest User"),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Text(
                              "${profilemanager.profileDataList?.country_code ?? ""}${profilemanager.profileDataList?.phone_no ?? "+91**********"}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              onTap: () {
                token == "null" || token.toString().isEmpty
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateProfileView(provider: provider),
                        ),
                      );
              },
            );
          }),

          /// PROFILE VIEW

          // start auth section

          // USER INFORNATION
          (token == "null" || token.toString().isEmpty)
              ? Container()
              : userInfo(),
          // NOTIFICATION SETTINGS
          (token == "null" || token.toString().isEmpty)
              ? Container()
              : notificationView(),
          // OTHER INFORMATION
          otherView(),
          // GENERAL SETTIMGS
          (token == "null" || token.toString().isEmpty)
              ? Container()
              : generalSettings()
        ],
      ),
    );
  }

  userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantText.userInformation,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.settingTextColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            child: SettingComponent(
              lable: ConstantText.profile,
              imageName: "assets/icons/profile_33.png",
              callBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfileView(
                      provider: provider,
                    ),
                  ),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProfileView(
                            provider: provider,
                          )));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            child: SettingComponent(
              lable: ConstantText.orderHistory,
              imageName: "assets/icons/iconOrderHistory.png",
              callBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderHistoryView(),
                  ),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistoryView(),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddressBookView()));
            },
            child: SettingComponent(
                lable: ConstantText.addressBook,
                imageName: "assets/icons/iconAddressBook.png",
                callBack: () {
                  print("---onTap");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressBookView()));
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Divider(
            color: AppColor.dividerColor,
          ),
        ),
      ],
    );
  }

  notificationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantText.notificationSettings,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.settingTextColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: notificationSettingComponent(
            is_email: profilemanager.profileDataList?.isEmail,
            is_noti: profilemanager.profileDataList?.isNotification,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Divider(
            color: AppColor.dividerColor,
          ),
        ),
      ],
    );
  }

  otherView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantText.otherInformation,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.settingTextColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtherInformationPageView(
                              type: "about_us",
                            )));
              },
              child: SettingComponent(
                  lable: ConstantText.aboutUs,
                  imageName: "assets/icons/iconAboutUs.png",
                  callBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtherInformationPageView(type: "about_us"),
                      ),
                    );
                  }),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OtherInformationPageView(type: "privacy_policy"),
                  ),
                );
              },
              child: SettingComponent(
                  lable: ConstantText.privacyPolicy,
                  imageName: "assets/icons/privacyPolicyLock.png",
                  callBack: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtherInformationPageView(type: "privacy_policy"),
                      ),
                    );
                  }),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OtherInformationPageView(type: "term_and_condition"),
                  ),
                );
              },
              child: SettingComponent(
                lable: ConstantText.terms,
                imageName: "assets/icons/iconLetter.png",
                callBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OtherInformationPageView(type: "term_and_condition"),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OtherInformationPageView(type: "contact_us"),
                  ),
                );
              },
              child: SettingComponent(
                lable: ConstantText.contactUs,
                imageName: "assets/icons/iconLetter.png",
                callBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OtherInformationPageView(type: "contact_us"),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }

  generalSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Divider(
            color: AppColor.dividerColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ConstantText.generalSetting,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.settingTextColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordView(),
                    ),
                  );
                },
                child: SettingComponent(
                    lable: ConstantText.changePassword,
                    imageName: "assets/icons/changePassword.png",
                    callBack: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordView(),
                        ),
                      );
                    }),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeleteAccountView(),
                    ),
                  );
                },
                child: SettingComponent(
                  lable: ConstantText.deleteAccount,
                  imageName: "assets/icons/deleteAccount.png",
                  callBack: () {
                    dismissWaitDialog();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeleteAccountView(),
                      ),
                    );
                  },
                ),
              ),

              InkWell(
                // child: SettingComponent(
                //   lable: ConstantText.logOut,
                //   imageName: "assets/icons/logOut.png",
                //   callBack: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text(
                //             ConstantText.logOut,
                //           ),
                //           content: const Text(ConstantText.askLogOut,
                //               style: TextStyle(fontSize: 14)),
                //           actions: <Widget>[
                //             Container(
                //               height: 35,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   color: AppColor.redThemeClr),
                //               child: TextButton(
                //                 child: const Text(ConstantText.cancel,
                //                     style: TextStyle(color: Colors.white)),
                //                 onPressed: () {
                //                   Navigator.of(context).pop();
                //                 },
                //               ),
                //             ),
                //             Container(
                //               height: 35,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   color: AppColor.redThemeColor),
                //               child: TextButton(
                //                 child: const Text(ConstantText.confirm,
                //                     style: TextStyle(color: Colors.white)),
                //                 onPressed: () {
                //                   var manager = DeleteAccountManager();
                //                   manager.logOutAccount();
                //                   dismissWaitDialog();
                //                 },
                //               ),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            ConstantText.logOut,
                          ),
                          content: const Text(ConstantText.askLogOut,
                              style: TextStyle(fontSize: 14)),
                          actions: <Widget>[
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.redThemeClr),
                              child: TextButton(
                                child: const Text(ConstantText.cancel,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.redThemeColor),
                              child: TextButton(
                                child: const Text(ConstantText.confirm,
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  var manager = DeleteAccountManager();
                                  manager.logOutAccount();
                                  dismissWaitDialog();
                                },
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: SettingComponent(
                  lable: ConstantText.logOut,
                  imageName: "assets/icons/logOut.png",
                ),
              ), // GENERAL SETTINGS
            ],
          ),
        ),
      ],
    );
  }
}
