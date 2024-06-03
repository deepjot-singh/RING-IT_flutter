import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/localStore.dart';
import 'package:foodorder/app/modules/deleteAccountPage/remoteService/deleteAccountApi.dart';

import '../../../core/constant/globalVariable.dart';

class DeleteAccountManager {
  var isLoading = true;
  deleteAccount({onRefresh}) async {
    await DeleteAccountNetworkManager(dataManager: this).deleteAccount(
        onSuccess: () async {
      isLoading = false;
      await LocalStore().deleteUserAccount();
      Routes.gotoLogin(GlobalVariable.getRootContext());
      onRefresh();
    }, onError: () {
      isLoading = false;
    });
  }

  logOutAccount() async {
    await DeleteAccountNetworkManager(dataManager: this).logOutAccount(
        onSuccess: () async {
      isLoading = false;
      await LocalStore().logOutUserAccount();
      Routes.gotoLogin(GlobalVariable.getRootContext());
    }, onError: () {
      isLoading = false;
    });
  }


}
