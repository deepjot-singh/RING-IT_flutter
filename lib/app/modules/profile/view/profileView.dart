import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/profile/component/addNumberShowAlert.dart';
import 'package:foodorder/app/modules/profile/manager/profileManager.dart';
import 'package:foodorder/app/modules/profile/manager/updatePhonemanager.dart';
import 'package:foodorder/app/modules/profile/provider/profileProvider.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../core/appColor/appColor.dart';
import '../../../core/constantKeys/constantKeys.dart';
import '../../../widgets/CustomTF/textfields/textFields.dart';
import '../../../widgets/customBtn/customBtn.dart';
import '../../settingPage/view/settingView.dart';

class UpdateProfileView extends StatefulWidget {
  var provider = ProfileProvider();

  UpdateProfileView({super.key, required this.provider});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  var imageSelected = ImageSelected();
  var manager = ProfileManager();
  var updateManager = UpdatePhoneManager();
  var provider = ProfileProvider();

  File? imageChoosen;
  var otp;
  @override
  void initState() {
    print("object");
    // TODO: implement initState
    super.initState();
    provider = widget.provider;
    manager = provider.manager;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileData();
    });
  }

  getProfileData() async {
    otp = await LocalStore().getOTP();
    await provider.profileDataRepresent();
    print("12345678");

    // await manager.validation(onRefresh: (){
    //   setState(() {

    //   });
    // });
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // UpdatePhoneManager updateManager;
    // var imageTemp;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomHomeIconAppBar(
          title: ConstantText.updateProfile,
        ),
        body: bodyView(context),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    print("Name--${provider.manager.name.text}");
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<ProfileProvider>(builder: (context, object, child) {
        return (manager.profileDataList == null)
            ? Container() //loaderList()
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(child: setImage(manager.isChanged)),
                        TextFieldComponent(
                          onChange: (value) {
                            manager.isChanged = value.isNotEmpty;
                            print("changed--${manager.isChanged}");
                            provider.refresh();
                          },
                          controllr: manager.name, // ADD NAME CONTROLLER HERE
                          placeholder: ConstantText.name,
                          label: ConstantText.name,
                          //  manager.profileDataList[index].name.toString(),
                          height: 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                          onChange: (value) {
                            manager.isChanged = value.isNotEmpty;
                            print("changed--${manager.isChanged}");
                            provider.refresh();
                          },
                          controllr: manager.email, // ADD EMAIL CONTROLLER HERE
                          placeholder: ConstantText.email,
                          label: ConstantText.email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldComponent(
                          enabled: false,
                          controllr:
                              manager.phone_no, // ADD PHONE CONTROLLER HERE
                          placeholder: ConstantText.phnNumber1,
                          label: ConstantText.phnNumber1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //   MaterialPageRoute(builder: (context) => BottomUpModel()));
                          },
                          child: InkWell(
                            onTap: () {
                              AddNumberShowBottomPopUp(
                                  context: context,
                                  updateManager: updateManager,
                                  otp: otp);
                            },
                            child: Text(
                              ConstantText.changePhnNumber,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomButton.regular(
                          height: 50,
                          background: (manager.isChanged)
                              ? AppColor.redThemeColor
                              : AppColor.textFeildBdr,
                          shadow: false,
                          borderWidth: 0,
                          fontSize: 16,
                          radius: 10,
                          fontweight: FontWeight.bold,
                          title: ConstantText.update.toUpperCase(),
                          onTap: () {
                            if (manager.isChanged == true) {
                              provider.validation(
                                  onSuccess: () {
                                    manager.isChanged = false;
                                    provider.profileDataRepresent(
                                        needLoader: false);
                                  },
                                  onRefresh: () {
                                    setState(() {});
                                  },
                                  context: this);
                            } else {
                              // showAlert(
                              //   ConstantText.updateProfileMsg,
                              // );
                            }

                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => SettingPageView()));
                          },
                        ),
                      ]),
                ),
              );
      }),
    );
  }

  Widget setImage(isChanged) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Stack(children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              height: 150,
              width: 150,
              decoration: new BoxDecoration(
                color: Colors.grey[150],
                shape: BoxShape.circle,
              ),
              // height: 150,
              // width: 150,

              child: imageChoosen != null
                  ? Image.file(
                      imageChoosen!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : manager.selectedImage.toString() != "null"
                      ? ClipOval(
                          child: CachedNetworkImage(
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              imageUrl: manager.selectedImage.toString(),
                              placeholder: (context, url) => loaderList(),
                              errorWidget: (context, url, error) => Image.asset(
                                    "assets/images/profileImage.png",
                                    height: 90,
                                    width: 90,
                                  )
                              // Icon(Icons.error),
                              ),
                        )
                      // Image.file(
                      //     imageChoosen!,
                      //     width: 150,
                      //     height: 150,
                      //     fit: BoxFit.cover,
                      //   )

                      : Image.asset(
                          "assets/images/profileImage.png",
                          height: 80,
                        ),
            ),
            Positioned(
              bottom: 2,
              left: 100,
              child: InkWell(
                onTap: () {
                  print("clickedImage11");
                  imageSelectAlert(
                    isChanged: isChanged,
                    onSelected: () async {
                      print(
                          "finalselectedImage -${ImageSelected().file?.path}");
                      print(
                          "finalselectedImage22 -${ImageSelected().file?.runtimeType}");
                      // var urlProfileImage = await EditUserDataApi()
                      //     .uploadProfileImage(imageFile: ImageSelected().file!.path);
                      // print("finalselectedImageapi -${urlProfileImage}");
                      //   userImage = urlProfileImage ?? "";
                      // print("finalselectedImageapi1 -${userImage}");
                      // Constant.taskProvider.userImage = userImage;
                      // Constant.taskProvider.notifyListeners();
                      setState(() {});
                    },
                  );
                },
                child: Icon(
                  Icons.add_circle_sharp,
                  size: 35,
                  color: Colors.grey,
                ),
              ),
            )
          ]),
          Text(
            capitalize(manager.name.text),
            // "Tushar sharma",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  imageSelectAlert({required onSelected, isChanged}) {
    showGalleryCameraMenu(
      "Select Image Source",
      onGallery: () async {
        manager.changeImage = true;

        Navigator.of(context).pop();

        print("Gallerycapture");
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        print("Gallerycapture - ${image}");
        if (image == null) {
          print("notSelected ");
          return;
        } else {
          var imageTemp = File(image.path);
          print("imagePath--${imageTemp}");
          manager.imageSelector = imageTemp;
          setState(() {
            manager.isChanged = true;
            print("changed--${manager.changeImage}");
            imageChoosen = imageTemp;
          });
        }
      },
      onCamera: () async {
        manager.changeImage = true;
        var status = await cameraPermissionEnable();
        if (!status!) {
          return;
        }
        Navigator.of(context).pop();
        print("Cameracapture - ${onSelected}");
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        print("Gallerycapture - ${image}");
        if (image == null) {
          print("notSelected ");
          return;
        } else {
          var imageTemp = File(image.path);
          print("imagePath--${imageTemp}");
          manager.imageSelector = imageTemp;
          setState(() {
            manager.isChanged = true;
            isChanged = true;
            print("changed--${manager.changeImage}");
            imageChoosen = imageTemp;
          });
        }
      },
    );
  }

  captureImage(ImageSource source, {required onSelected}) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? file = await _picker.pickImage(source: source);
    ImageSelected().fromUrl = false;
    ImageSelected().path = file!.path;
    ImageSelected().file = File(file.path);
    print("imageSelected - ${ImageSelected().file}");
    onSelected();
    // Capture a photo
  }

  Future<bool?> cameraPermissionEnable() async {
    var cameraPermission = await Permission.camera.status;
    var msg = "This app needs camera access to take pictures for upload photo.";
    print(" cameraPermission $cameraPermission");
    if (cameraPermission == PermissionStatus.granted) {
      return true;
    } else if (cameraPermission == PermissionStatus.denied ||
        cameraPermission == PermissionStatus.permanentlyDenied) {
      if (Platform.isIOS) {
        if (cameraPermission == PermissionStatus.denied) {
          return await Permission.camera.request().isGranted;
        } else {
          onAppSettingPop(msg);
          return false;
        }
      } else {
        return await Permission.camera.request().isGranted;
      }
    } else if (cameraPermission == PermissionStatus.permanentlyDenied ||
        cameraPermission == PermissionStatus.restricted) {
      onAppSettingPop(msg);
      return false;
    }
  }

  void showGalleryCameraMenu(msg,
      {bool pop = false,
      VoidCallback? onTap,
      VoidCallback? onCamera,
      VoidCallback? onGallery,
      barrierDismiss = false,
      String btnName = "OK"}) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 150.0,
        width: 200.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    msg,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: CustomButton.regular(
                            // width: 110,
                            background: AppColor.redThemeColor,
                            title: ConstantText.gallery,
                            fontSize: 15,
                            height: 35,
                            onTap: () {
                              onGallery!();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: CustomButton.regular(
                            // width: 110,
                            background: AppColor.redThemeColor,
                            title: ConstantText.camera,
                            height: 35,
                            fontSize: 15,
                            fontweight: FontWeight.w400,
                            onTap: () {
                              onCamera!();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.redThemeClr,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  onAppSettingPop(String permission) {
    showDialog(
      context: Keys.navigatorKey.currentState!.overlay!.context,
      builder: (context) => new AlertDialog(
        content: new Text(permission),
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              ConstantText.cancel,
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              //openAppSettings();
            },
            child: Text(
              ConstantText.setting,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSelected {
  File? file;
  String imageUrl = "";
  String path = "";
  bool fromUrl = false;
}
