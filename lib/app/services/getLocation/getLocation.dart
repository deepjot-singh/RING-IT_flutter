import 'package:foodorder/app/core/constant/constText.dart';
import 'package:foodorder/app/core/networking/internetCheck.dart';
import 'package:foodorder/app/modules/productListPage/manager/productListManager.dart';
import 'package:foodorder/app/widgets/commonDailogs/commonDailogs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationDetector {
  late double currLat;
  late double currLng;
  String? fullAddress;
  String? houseNo;
  String? locality;
  String? pin;
  ProductsListManager productManager = ProductsListManager();
  getLocation({onRefresh, onSuccess}) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("LOCATION PERMISSION DENIED");
      LocationPermission ask = await Geolocator.requestPermission();
      if (ask == LocationPermission.whileInUse ||
          ask == LocationPermission.always) {
        // Execute logic to retrieve location after permission is granted
        _retrieveLocation(onRefresh, onSuccess);
      }
    } else {
      // Execute logic to retrieve location without asking for permission
      _retrieveLocation(onRefresh, onSuccess);
    }
  }

  _retrieveLocation(onRefresh, onSuccess) async {
    print("Retrieving location...");
    onRefresh();
    Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Lat==  ${currentLocation.latitude.toString()}");
    currLat = currentLocation.latitude;
    print("Lng==  ${currentLocation.longitude.toString()}");
    currLng = currentLocation.longitude;
    if (await internetCheck() == false) {
      showInternetAlert(
          msg: ConstantText.msgInterNetLost,
          title: ConstantText.titleInterNetLost);
      return "";
    }
    List<Placemark> result = await placemarkFromCoordinates(currLat, currLng);
    if (result.isNotEmpty) {
      fullAddress =
          '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
      houseNo = '${result[0].name}';
      locality = '${result[0].locality}';
      pin = '${result[0].postalCode}';

      print("Full Address: $fullAddress");
      productManager.userPlaceOrderAddress = fullAddress!;
      print(
          'productManager.userPlaceOrderAddress ${productManager.userPlaceOrderAddress}');
      onRefresh();
      // Move onSuccess callback here to ensure fullAddress is populated before calling it
      onSuccess(fullAddress, currLat, currLng);
    }
  }
}
