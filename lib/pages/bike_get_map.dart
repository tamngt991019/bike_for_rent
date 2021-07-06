import 'dart:async';

import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;

class BikeGetMap extends StatefulWidget {
  final UserModel userModel;
  final BookingModel bookingModel;
  const BikeGetMap({Key key, this.userModel, this.bookingModel})
      : super(key: key);

  @override
  _BikeGetMapState createState() => _BikeGetMapState();
}

class _BikeGetMapState extends State<BikeGetMap> {
  String _currentAddress = "";
  String _bikeGetAddress = "";
  bool _isShowConfirmBtn = false;
  BookingModel _bookingModel;

  LatLng _currentLatLing;

  CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(10.82414068863801, 106.63065063707423), zoom: 15);

  Completer<GoogleMapController> _ggMapController = Completer();
  Set<Marker> _markers = {};

  void moveCamera() async {
    final GoogleMapController controller = await _ggMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      _initialCameraPosition,
    ));
  }

  Future<String> getAddress(LatLng _inLatLing) async {
    final coordinates =
        new Coordinates(_inLatLing.latitude, _inLatLing.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine;
  }

  void getLocation(LatLng _inLatLing) {
    setState(() {
      // _markers.
      _markers.clear();

      _markers.add(
        Marker(
          markerId: MarkerId("ID-1"),
          position: _currentLatLing,
        ),
      );
      getAddress(_currentLatLing).then((add1) {
        setState(() {
          this._currentAddress = add1;
        });
      });
      if (_inLatLing != null) {
        _isShowConfirmBtn = true;
        _markers.add(
          Marker(
            markerId: MarkerId("ID-2"),
            position: _inLatLing,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta),
          ),
        );

        getAddress(_inLatLing).then((add2) {
          setState(() {
            this._bikeGetAddress = add2;
          });
        });
        _initialCameraPosition = CameraPosition(target: _inLatLing, zoom: 12);
      }

      moveCamera();
    });
  }

// 10.867108878090859, 106.8030191050504
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLatLing = LatLng(position.latitude, position.longitude);
    });
    getLocation(null);
    _initialCameraPosition = CameraPosition(target: _currentLatLing, zoom: 12);
  }

  void _onMapCreated(GoogleMapController _controller) {
    _ggMapController.complete(_controller);

    setState(() {
      getCurrentLocation();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._bookingModel = widget.bookingModel;
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
              titles: "Thuê xe",
              isShowBackBtn: false,
              // onPressedBackBtn: () => helper.pushInto(
              // context, RentBikeFilter(userModel: widget.userModel), false),
            ),
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
                  // htong tin vi tri
                  ExpandChild(
                    arrowColor: my_colors.primary,
                    arrowSize: 50,
                    expandedHint: "Xem thêm",
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
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
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Địa điểm của bạn: ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
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
                                              thickness: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_bikeGetAddress.isNotEmpty)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        elevation: 5,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Địa điểm nhận xe: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: my_colors.primary),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                _bikeGetAddress,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Divider(
                                                height: 10,
                                                color: my_colors.primary,
                                                thickness: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (_isShowConfirmBtn)
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
                                  onPressedElavateBtn: () {
                                    if (_bookingModel == null) {
                                      _bookingModel = new BookingModel();
                                    } else {
                                      _bookingModel.userName =
                                          widget.userModel.username;
                                      // _bookingModel.locationGetBike =
                                    }

                                    helper.pushInto(
                                        context,
                                        RentBikeFilter(
                                          userModel: widget.userModel,
                                          bookingModel: _bookingModel,
                                        ),
                                        true);
                                  }),
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
            bottomNavigationBar: BottomBar(
              bottomBarIndex: 1,
              userModel: widget.userModel,
            ),
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
                "Danh sách địa điểm nhận xe gần bạn",
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
                      getLocation(LatLng(10.841493, 106.810038));
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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      getLocation(
                          LatLng(10.867108878090859, 106.8030191050504));
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
                              "Khu du lịch văn hóa Suối Tiên",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
