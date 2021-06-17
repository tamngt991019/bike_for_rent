import 'dart:async';
import 'dart:ui';

import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class ReturnBikeMap extends StatefulWidget {
  ReturnBikeMap({Key key}) : super(key: key);

  @override
  _ReturnBikeMapState createState() => _ReturnBikeMapState();
}

class _ReturnBikeMapState extends State<ReturnBikeMap> {
  static double _latitude = 10.841493;
  static double _longitude = 106.810038;
  String _markerId = "ID-1";
  String locMess = "";
  String _currentAddress = "";

  Position position;

  static LatLng _myLatLing = LatLng(_latitude, _longitude);

  CameraPosition _initialCameraPosition =
      CameraPosition(target: _myLatLing, zoom: 15);

  // GoogleMapController _ggMapController;
  Completer<GoogleMapController> _ggMapController = Completer();

  Set<Marker> _markers = {};

  void moveCamera() async {
    final GoogleMapController controller = await _ggMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      _initialCameraPosition,
    ));
  }

  void getAddress() async {
    final coordinates = new Coordinates(_latitude, _longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    // print("${first.featureName} : ${first.addressLine}");
    setState(() {
      _currentAddress = first.addressLine.toString();
    });

    // print(
    //     ' ${first.locality} - ${first.adminArea} - ${first.subLocality} - ${first.subAdminArea} - ${first.addressLine} - ${first.featureName} - ${first.thoroughfare} - ${first.subThoroughfare}');
  }

  void getLocation(double _inLatitude, double _inLongitude) {
    setState(() {
      _latitude = _inLatitude;
      _longitude = _inLongitude;
      _myLatLing = LatLng(_latitude, _longitude);
      _initialCameraPosition = CameraPosition(target: _myLatLing, zoom: 15);

      locMess = "\n _Latitude: $_latitude \n _Longitude: $_longitude";
      // _markers.
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId(_markerId),
          position: _myLatLing,
        ),
      );

      moveCamera();
      getAddress();
    });
  }

  void getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getLocation(position.latitude, position.longitude);
  }

  void _onMapCreated(GoogleMapController _controller) {
    _ggMapController.complete(_controller);

    setState(() {
      getLocation(_latitude, _longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Stack(
        children: [
          Scaffold(
            // Header app
            appBar: Appbar(
                height: 50,
                titles: "Titles text",
                isShowBackBtn: true,
                bottomAppBar: null,
                onPressedBackBtn: () {}),
            // Body app
            body: Container(
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    initialCameraPosition: _initialCameraPosition,
                    markers: _markers,
                    onMapCreated: _onMapCreated,
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              margin:
                                  EdgeInsets.only(left: 20, right: 10, top: 20),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Địa chỉ hiện tại: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: my_colors.primary),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      _currentAddress,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Divider(
                                      height: 10,
                                      color: my_colors.primary,
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                                // TextField(
                                //   controller: TextEditingController()
                                //     ..text = _currentAddress,
                                //   minLines: 1,
                                //   keyboardType: TextInputType.multiline,
                                //   maxLines: null,
                                //   readOnly: true,
                                //   autofocus: true,
                                //   decoration: InputDecoration(
                                //     labelText: "Địa chỉ hiện tại",
                                //     labelStyle: TextStyle(
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(15),
                                //     ),
                                //   ),
                                //   style: TextStyle(fontSize: 15),
                                //   onChanged: (text) => {},
                                // ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.only(right: 20, top: 20),
                            child: IconButton(
                              icon:
                                  Image.asset('lib/assets/images/location.png'),
                              iconSize: 35,
                              onPressed: getCurrentLocation,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: ElavateBtn(
                              title: "Xác nhận vị trí",
                              width: 200,
                              onPressedElavateBtn: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.only(
                                left: 10, right: 20, bottom: 20),
                            child: IconButton(
                              icon: Icon(Icons.more_horiz),
                              color: my_colors.primary,
                              iconSize: 25,
                              onPressed: () {
                                _listLocationBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(),
          ),
        ],
      ),
    );
  }

  void _listLocationBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            title: Center(
              child: Text(
                "Danh sách địa điểm trả xe",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: my_colors.primary,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                // loop cái card thôi
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      getLocation(10.841493, 106.810038);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.asset(
                            'lib/assets/images/location.png',
                            scale: 10,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              "Đại học FPT Hồ Chí Mính",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
