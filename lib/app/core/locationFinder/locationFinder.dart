import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodorder/app/core/appColor/appColor.dart';
import 'package:foodorder/app/core/constantKeys/constantKeys.dart';
import 'package:foodorder/app/modules/addAddressPage/addAddressManager/addAddressManager.dart';
import 'package:foodorder/app/services/getLocation/getLocation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class LocationFinderComponent extends StatefulWidget {
  LocationFinderComponent(
      {super.key, this.updatedData, required this.manager, this.locationData});
  Function()? updatedData;
  AddAddressManager manager;
  Function(String)? locationData;
  @override
  State<LocationFinderComponent> createState() =>
      _LocationFinderComponentState();
}

class _LocationFinderComponentState extends State<LocationFinderComponent> {
  LatLng myLatLng = LatLng(31.6573888, 74.8538088);
  String? myAddress = "LA";
  //LatLng(37.42796133580664, -122.085749655962);
  String fullAddress = "";
  String? houseNo = "";
  String? locality = "";
  String? pin = "";
  String? currLat = "";
  String? currLng = "";
  String? updatedLat = "";
  String? dragedLat = "";
  String? dragedlng = "";
  String? updatedLng = "";
  String? newLat = "";
  String? newLng = "";
  String currfullAddress = "";
  String? currhouseNo = "";
  String? currlocality = "";
  String? currpin = "";
  String draggedAddress = "";
  String draggedlocality = "";
  FocusNode focusNode = FocusNode();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.0414, 75.4031),
    zoom: 14.4746,
    //
  );
  TextEditingController controller = TextEditingController();

  getlocation() async {
    print("jjjkjk");
    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied ||
    //     permission == LocationPermission.deniedForever) {
    //   print("LOCATION PREMISSION DENIED");
    //   LocationPermission ask = await Geolocator.requestPermission();
    // } else {
    Position currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Lat==  ${currentLocation.latitude.toString()}");
    currLat = currentLocation.latitude.toString();
    print("Lng==  ${currentLocation.longitude.toString()}");
    currLng = currentLocation.longitude.toString();

    setState(() {
      _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(currLat ?? '32.0414'),
              double.parse(currLng ?? '75.4031')),
          zoom: 15);

      print("home${houseNo}");
      print("home${locality}");
      print("home${pin}");
    });

    _goToTheLake();

    goToForm(currLat, currLng);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getlocation();
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
  //  void _updatePosition(CameraPosition _position) {
  //   print("kkkkkkkkkkkkkkkkkkkkkkkkk-${_position}");
  //  }

  updateCameraPosition(LatLng value) async {
    dragedLat = value.latitude.toString();
    dragedlng = value.longitude.toString();
    print("updatedlat ==${dragedLat}");
    print("updatedlat ==${dragedlng}");
    List<Placemark> result = await placemarkFromCoordinates(
        double.parse(dragedLat ?? '32.0414'),
        double.parse(dragedlng ?? '75.4031'));
    if (result.isNotEmpty) {
      print("Egypt");
      draggedAddress =
          '${result[0].name},${result[0].locality}, ${result[0].administrativeArea}';
      var draggedhouseNo = '${result[0].name}';

      print("updatedlaaat ==${draggedhouseNo}");
      widget.manager.houseNoTF.text = draggedhouseNo ?? "";
      var draggedlocality = '${result[0].locality}';

      print("updatedlaaat ==${draggedlocality}");
      widget.manager.localityTF.text = draggedlocality ?? "";
      var draggedadministrativeArea = '${result[0].administrativeArea}';
      print("updatedlaaat == ${draggedadministrativeArea}");
      var draggedpin = '${result[0].postalCode}';

      widget.manager.pincodeTF.text = draggedpin ?? "";

      widget.manager.latTF.text = dragedLat ?? '32.0414';
      widget.manager.lngTF.text = dragedlng ?? '32.0414';
    }

    setState(() {
      _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(dragedLat ?? '32.0414'),
              double.parse(dragedlng ?? '75.4031')),
          zoom: 15);
      widget.locationData!(draggedAddress);
    });

    _goToTheLake();
  }

  newCameraPosition(Latitude, Longitude) async {
    print("here-${Latitude}");
    print("here-${Longitude}");
    //   List<Placemark> result = await placemarkFromCoordinates(
    //     double.parse(Latitude?? '32.0414'),
    //     double.parse(Longitude ?? '75.4031'));

    // if (result.isNotEmpty) {
    //   fullAddress =
    //       '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
    //   houseNo = '${result[0].name}';
    //      print("here22-${Longitude}");
    //   locality = '${result[0].locality}';
    //   pin = '${result[0].postalCode}';
    // }
    setState(() {
      print("jjknkjkjk");
      _kGooglePlex = CameraPosition(
          target: LatLng(double.parse(Latitude ?? '32.0414'),
              double.parse(Longitude ?? '75.4031')),
          zoom: 15);
      // _kGooglePlex = CameraPosition(target: value, zoom: 15);
    });

    _goToTheLake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Stack(
          children: [
            Container(
              // height: 850,
              //  width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                onCameraMove: (_position) {},
                //((_position) => _updatePosition(_position)),
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                //  zoomGesturesEnabled: false,
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.hybrid,

                compassEnabled: true,
                padding: EdgeInsets.only(top: 490),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: MarkerId('1'),
                    draggable: true,
                    position: _kGooglePlex.target,
                    //myLatLng,

                    infoWindow: InfoWindow(title: fullAddress),
                    onDragEnd: (LatLng value) {
                      print("LATLONG--${value}");
                      updateCameraPosition(value);
                      // setMaker(value);
                    },
                  ),
                },
                onTap: (LatLng value) {
                  print("OnTapgLATLONG--${value}");
                  setMaker(value);
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.12,
              // top: 50,
              right: 0,
              left: 0,
              // height: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 9, top: 5, bottom: 5, right: 2),
                            child: Icon(Icons.arrow_back_ios,
                                size: 25, color: AppColor.blackstd),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        // height: 45,
                        // width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        // padding: EdgeInsets.only(bottom: 3),
                        child: GooglePlaceAutoCompleteTextField(
                          textEditingController:
                              controller, // ADD controller HERE
                          googleAPIKey: Keys.AutoGoogleMaps,
                          focusNode: focusNode,

                          inputDecoration: InputDecoration(
                              hintText: "Search your location",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 18)
                              //prefix: Icon(Icons.search_off, color: Colors.black,size: 10,)
                              ),
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          countries: ["in"],
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            focusNode.unfocus();
                            newLat = prediction.lat.toString();
                            newLng = prediction.lng.toString();
                            print("placeDetails" + prediction.toString());
                            print(
                                "placeDetailslng" + prediction.lng.toString());
                            print(
                                "placeDetailsLat" + prediction.lat.toString());
                            print(
                                "address placeDetails--${prediction.description}");
                            widget.manager.localityTF.text =
                                prediction.description ?? "";
                            fetchAddress(prediction);
                            print("address--${prediction.matchedSubstrings}");
                            newCameraPosition(newLat, newLng);
                            widget.locationData!(prediction.description ?? "");
                            setState(() {
                              updatedLat = newLat;
                              updatedLng = newLng;
                            });
                          },
                          itemClick: (Prediction prediction) {
                            focusNode.unfocus();
                            controller.text = prediction.description ?? "";
                            print(
                                "fetchLocationText--_${controller.value.text}");
                            widget.manager.localityTF.text =
                                controller.value.text;
                            print(
                                "fetchLocationText22--_${controller.value.text}");
                            controller.selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        prediction.description?.length ?? 0));
                            setState(() {});
                          },
                          itemBuilder: (context, index, Prediction prediction) {
                            widget.manager.localityTF.text =
                                prediction.description ?? "";
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: AppColor.redThemeColor,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                          "${prediction.description ?? ""}"))
                                ],
                              ),
                            );
                          },
                          seperatedBuilder: Divider(),
                          isCrossBtnShown: true,
                          containerHorizontalPadding: 40,
                          // containerVerticalPadding:- ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetchAddress(Prediction prediction) async {
    // myLatLng = value;
    List<Placemark> result = await placemarkFromCoordinates(
        double.parse(prediction.lat ?? updatedLat ?? '32.0414'),
        double.parse(prediction.lat ?? updatedLat ?? '75.4031'));

    if (result.isNotEmpty) {
      fullAddress =
          '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
      houseNo = '${result[0].name}';
      locality = '${result[0].locality}';
      pin = '${result[0].postalCode}';
    }

    setState(() {
      //   widget.manager.houseNoTF.text = houseNo ?? "";
      widget.manager.pincodeTF.text = pin ?? "";
      //   widget.manager.localityTF.text = locality ?? "";
      widget.manager.latTF.text = prediction.lat ?? updatedLat ?? '32.0414';
      widget.manager.lngTF.text = prediction.lng ?? updatedLat ?? '32.0414';

      print("home${houseNo}");
      print("home${locality}");
      print("home${pin}");
    });

    //  widget.locationData!(locality ?? "");
  }

  setMaker(LatLng value) async {
    print("jjjjjj");
    // myLatLng = value;
    List<Placemark> result =
        await placemarkFromCoordinates(value.latitude, value.longitude);

    if (result.isNotEmpty) {
      fullAddress =
          '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
      houseNo = '${result[0].name}';
      locality = '${result[0].locality}';
      pin = '${result[0].postalCode}';
    }
    setState(() {});
    // widget.locationData!(draggedAddress);
  }

  goToForm(String? currentLat, String? currentLng) async {
    List<Placemark> result = await placemarkFromCoordinates(
        double.parse(currentLat ?? '32.0414'),
        double.parse(currentLng ?? '75.4031'));

    if (result.isNotEmpty) {
      currfullAddress =
          '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
      // currhouseNo = '${result[0].name}';
      print("currhouseNo${currhouseNo}");
      currlocality = '${result[0].locality}';
      currpin = '${result[0].postalCode}';
      // currfullAddress = '${result[0].locality}';
    }

    setState(() {
      // widget.manager.houseNoTF.text = currhouseNo ?? "";
      widget.manager.pincodeTF.text = currpin ?? "";
      widget.manager.localityTF.text = currfullAddress ?? "";
      widget.manager.latTF.text = currentLat ?? '32.0414';
      widget.manager.lngTF.text = currentLng ?? '32.0414';

      print("home${houseNo}");
      print("home${locality}");
      print("home${pin}");
    });
    widget.locationData!(currfullAddress);
  }
}
