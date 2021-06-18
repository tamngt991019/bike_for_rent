import 'dart:async';

import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static double _latitude = 10.841493;
  static double _longitude = 106.810038;
  String _markerId = "ID-1";
  String locMess = "";
  String _currentAddress = "";

  Position position;

  static LatLng _myLatLing = LatLng(_latitude, _longitude);

  CameraPosition _initialCameraPosition =
      CameraPosition(target: _myLatLing, zoom: 13);

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
      _initialCameraPosition = CameraPosition(target: _myLatLing, zoom: 13);

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
            appBar: AppBar(
              toolbarHeight: 0,
              //   title:
            ),
            // Body app
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // thông tin người dùng
                  Row(
                    children: [
                      // avatar
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                      ),
                      SizedBox(width: 20),
                      // tên người dùng và sđt
                      Expanded(
                        // tên người dùng
                        child: Text(
                          "Tên người thuê / cho thuê",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // thông tin vị trí
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Địa chỉ hiện tại:",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: my_colors.primary),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _currentAddress,
                              style: TextStyle(fontSize: 15),
                            ),
                            Divider(
                              height: 20,
                              color: my_colors.primary,
                              thickness: 2,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: Image.asset('lib/assets/images/location.png'),
                          iconSize: 35,
                          onPressed: getCurrentLocation,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // map
                  Container(
                    height: 300,
                    child: GoogleMap(
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      initialCameraPosition: _initialCameraPosition,
                      markers: _markers,
                      onMapCreated: _onMapCreated,
                    ),
                  ),
                  SizedBox(height: 20),
                  // nút chọn loại xe / địa điểm thuê
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: IconButton(
                              icon: Image.asset('lib/assets/images/xeso.png'),
                              iconSize: 50,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Xe số",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: my_colors.primary),
                          )
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            child: IconButton(
                              icon:
                                  Image.asset('lib/assets/images/xetayga.png'),
                              iconSize: 50,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Xe tay ga",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: my_colors.primary),
                          )
                        ],
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80 - 150,
                        height: 45,
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Vị trí khác",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 30,
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  my_colors.primary)),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Các địa điểm nổi bật ở gần bạn:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/images/location.png',
                              scale: 10,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thác Dalanta",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Quốc lộ 20, đèo Prenn, phường 3, thành phố Đà Lạt, tỉnh Lâm Đồng",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/images/location.png',
                              scale: 10,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thác Dalanta",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Quốc lộ 20, đèo Prenn, phường 3, thành phố Đà Lạt, tỉnh Lâm Đồng",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/images/location.png',
                              scale: 10,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thác Dalanta",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Quốc lộ 20, đèo Prenn, phường 3, thành phố Đà Lạt, tỉnh Lâm Đồng",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/images/location.png',
                              scale: 10,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thác Dalanta",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Quốc lộ 20, đèo Prenn, phường 3, thành phố Đà Lạt, tỉnh Lâm Đồng",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/images/location.png',
                              scale: 10,
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thác Dalanta",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Quốc lộ 20, đèo Prenn, phường 3, thành phố Đà Lạt, tỉnh Lâm Đồng",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(
              bottomBarIndex: 0,
            ),
          ),
        ],
      ),
    );
  }
}
