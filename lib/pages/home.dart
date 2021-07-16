import 'dart:async';

import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_get_map.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;

class Home extends StatefulWidget {
  final UserModel userModel;
  Home({Key key, this.userModel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // UserModel userModel = new UserModel(
  //   // username: "testcustomer1",
  //   // password: null,
  //   // fullName: "Customer Number 1",
  //   // dateCreated: "2021-06-22T09:33:42.937",
  //   // email: null,
  //   // phone: null,
  //   username: "testcustomer1",
  //   password: null,
  //   fullName: "Customer Number 1",
  //   email: null,
  //   phone: null,
  //   avatar: null,
  //   dateCreated: "2021-06-22T09:33:42.937",
  //   userVerified: null,
  //   identityNo: null,
  //   frontIdentityImage: null,
  //   backIdentityImage: null,
  //   ownerVerified: null,
  //   isRenting: null,
  //   status: "ACTIVE",
  // );
  static double _latitude = 10.841493;
  static double _longitude = 106.810038;
  String _currentAddress = "";

  Position position;

  static LatLng _myLatLing = LatLng(_latitude, _longitude);

  CameraPosition _initialCameraPosition =
      CameraPosition(target: _myLatLing, zoom: 15);

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
    setState(() {
      _currentAddress = first.addressLine.toString();
    });
  }

  void getLocation(double _inLatitude, double _inLongitude) {
    setState(() {
      _latitude = _inLatitude;
      _longitude = _inLongitude;
      _myLatLing = LatLng(_latitude, _longitude);
      _initialCameraPosition = CameraPosition(target: _myLatLing, zoom: 15);

      // _markers.
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId("ID-1"),
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
      getCurrentLocation();
      // getLocation(_latitude, _longitude);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: AppBar(
          toolbarHeight: 0,
          //   title:
        ),
        // Body app
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thông tin người dùng
              Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: Row(
                  children: [
                    // avatar
                    CircleAvatar(
                      foregroundColor: Colors.white,
                      radius: 30,
                      backgroundImage: (widget.userModel != null)
                          ? NetworkImage(widget.userModel.avatar)
                          : AssetImage(
                              "lib/assets/images/avatar_logo.png",
                            ),

                      // NetworkImage(
                      //     "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                    ),
                    SizedBox(width: 15),
                    // tên người dùng và sđt
                    Expanded(
                      // tên người dùng
                      child: Text(
                        (widget.userModel != null)
                            ? widget.userModel.fullName
                            : "Xin chào,",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // thông tin vị trí
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrameText(
                    title: "Địa chỉ hiện tại:",
                    content: _currentAddress,
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
              // map
              Container(
                height: 300,
                child: GoogleMap(
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  onTap: (val) {
                    helper.pushInto(
                      context,
                      BikeGetMap(userModel: widget.userModel),
                      true,
                    );
                  },
                  initialCameraPosition: _initialCameraPosition,
                  markers: _markers,
                  onMapCreated: _onMapCreated,
                ),
              ),
              SizedBox(height: 10),
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
                          onPressed: () => helper.pushInto(
                            context,
                            BikeGetMap(
                              userModel: widget.userModel,
                              bikeTypeModel: BikeTypeModel(id: "XS"),
                            ),
                            true,
                          ),
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
                          icon: Image.asset('lib/assets/images/xetayga.png'),
                          iconSize: 50,
                          onPressed: () => helper.pushInto(
                            context,
                            BikeGetMap(
                              userModel: widget.userModel,
                              bikeTypeModel: BikeTypeModel(id: "XTG"),
                            ),
                            true,
                          ),
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
          userModel: widget.userModel,
        ),
      ),
    );
  }
}
