import 'package:foodorder/app/modules/addressBookPage/model/addressBookModel.dart';
import 'package:foodorder/app/modules/addressBookPage/remoteService/addressBookApi.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AddressBookManager {
  List<AddressBookDataModel> addressBook = [];
  RefreshController controller = RefreshController();
  var selectedIndex = -1;
  var isLoading = true;
  int pageNo = 1;
  getUserAddress({onRefresh, neeLoader = true, onSuccess}) {
    if (pageNo == 1) {
      isLoading = true;
      onRefresh();
    }
    print("hhhhhhhhhhhhh1");
    AddressBookNetworkManager(dataManager: this).dataRepresent(
        neeLoader: neeLoader,
        onSuccess: () {
          print("hhhhhhhhhhhhh2");
          isLoading = false;
          onRefresh();
          if (onSuccess != null) {
            onSuccess();
          }
        },
        onError: () {
          isLoading = false;
          onRefresh();
        });
  }

  //set default address
  // setUserDefaultAddress({onRefresh, userAddressId}) async {
  //   await AddressBookNetworkManager(dataManager: this).setDefaultAddress(
  //       onSuccess: () {
  //         print("adddressssIDdddd$userAddressId");
  //         isLoading = false;
  //         onRefresh();
  //       },
  //       onError: () {
  //         isLoading = false;
  //       },
  //       userAddressId: userAddressId);
  // }

  deleteUserAddress({onRefresh, userAddressId, required getData}) {
    print("iddddd-${userAddressId}");
    AddressBookNetworkManager(dataManager: this).deleteUserAddressAPi(
      getData: getData,
      userAddressId: userAddressId,
      onSuccess: () {
        isLoading = false;
        onRefresh();
      },
      onError: () {
        isLoading = false;
        onRefresh();
      },
    );
  }
}
