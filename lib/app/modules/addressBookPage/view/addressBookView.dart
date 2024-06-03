import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/stringFomart/stringFormat.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressProvider/addAddressProvider.dart';
import 'package:foodorder/app/modules/addAddressPage/view/addAddressPageView.dart';
import 'package:foodorder/app/modules/addressBookPage/manager/addressBookManager.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:foodorder/app/widgets/loader/loaderList.dart';
import 'package:foodorder/app/widgets/pullRefreshFooter/pullRefreshFooter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressBookView extends StatefulWidget {
  const AddressBookView({super.key});

  @override
  State<AddressBookView> createState() => _AddressBookViewState();
}

class _AddressBookViewState extends State<AddressBookView> {
  var manager = AddressBookManager();
  @override
  void initState() {
    super.initState();
    manager = GlobalVariable.addressProviderManager.managerBook;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressDetails();
    });
  }

  getAddressDetails() {
    manager.getUserAddress(
        neeLoader: false,
        onRefresh: () {
          GlobalVariable.addressProviderManager.refresh();
          // setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, object, child) {
      return Scaffold(
        appBar: CustomHomeIconAppBar(title: ConstantText.addressBookTitle),
        body: addressBookScreen(),
      );
    });
  }

  addressBookScreen() {
    return SmartRefresher(
      controller: manager.controller,
      header: MaterialClassicHeader(
        color: Colors.white,
        backgroundColor: AppColor.togglebtn,
      ),
      footer: PullRefreshFooter.getPullRefreshFooter(),
      enablePullUp: true,
      enablePullDown: true,
      onRefresh: () {
        manager.pageNo = 1;
        getAddressDetails();
        manager.controller.loadComplete();
        manager.controller.refreshCompleted();
      },
      onLoading: () {
        getAddressDetails();
        manager.controller.loadComplete();
        manager.controller.refreshCompleted();
      },
      child: Container(
        padding: EdgeInsets.only(right: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                  color: AppColor.redThemeColor,
                  borderRadius: BorderRadius.circular(7)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      ConstantText.addNewAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    print("jzjsafjk");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAddressPageView(
                          fromEditbtn: false,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: manager.isLoading
                    ? loaderList()
                    : manager.addressBook.isEmpty
                        ? noDataFound()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: manager.addressBook.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 220, 220, 220),
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  capitalize(manager
                                                          .addressBook[index]
                                                          .addressType) ??
                                                      "",
                                                  // manager.dataList![index].data!.id,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddAddressPageView(
                                                          fromEditbtn: true,
                                                          data: manager
                                                                  .addressBook[
                                                              index],
                                                          addressId: manager
                                                              .addressBook[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: SafeArea(
                                                      child: Image.asset(
                                                    "assets/icons/edit_icon.png",
                                                    height: 20,
                                                    width: 20,
                                                  )),
                                                ),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(ConstantText
                                                              .deleteAddress),
                                                          content: Text(
                                                              ConstantText
                                                                  .deleteAddressText,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          actions: <Widget>[
                                                            Container(
                                                              height: 35,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: AppColor
                                                                      .redThemeClr),
                                                              child: TextButton(
                                                                child: const Text(
                                                                    ConstantText
                                                                        .cancel,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 35,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: AppColor
                                                                      .redThemeColor),
                                                              child: TextButton(
                                                                child: const Text(
                                                                    ConstantText
                                                                        .confirm,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                                onPressed: () {
                                                                  manager
                                                                      .deleteUserAddress(
                                                                    getData:
                                                                        () {
                                                                      getAddressDetails();
                                                                    },
                                                                    onRefresh:
                                                                        () {
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    userAddressId: manager
                                                                        .addressBook[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                  );
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Image.asset(
                                                      "assets/icons/delete_icon.png",
                                                      height: 20,
                                                      width: 20),
                                                )
                                              ],
                                            ),

                                            ///  Spacer(),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              capitalize(manager
                                                  .addressBook[index].locality),
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              capitalize(manager
                                                      .addressBook[index]
                                                      .houseNumber) +
                                                  ", " +
                                                  capitalize(manager
                                                      .addressBook[index]
                                                      .landmark) +
                                                  ", " +
                                                  capitalize(manager
                                                      .addressBook[index]
                                                      .pincode),
                                              // manager.dataList![index].data!.address_type,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  )
                                ],
                              );
                            }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
