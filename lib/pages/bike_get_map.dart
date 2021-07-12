import 'dart:async';

import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/services/location_service.dart';
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
  final BikeTypeModel bikeTypeModel;
  final PayPackageModel payPackageModel;
  const BikeGetMap({
    Key key,
    this.userModel,
    this.bikeTypeModel,
    this.payPackageModel,
  }) : super(key: key);

  @override
  _BikeGetMapState createState() => _BikeGetMapState();
}

class _BikeGetMapState extends State<BikeGetMap> {
  static double cameraZoom = 15;
  String _currentAddress = "";
  String _bikeGetAddress = "";
  bool _isShowConfirmBtn = false;
  LatLng _currentLatLing;
  String selectedLocationId;
  LocationModel _locationModel;
  //==================================================================
  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(10.82414068863801, 106.63065063707423),
    zoom: cameraZoom,
  );

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
        _initialCameraPosition =
            CameraPosition(target: _inLatLing, zoom: cameraZoom);
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
    _initialCameraPosition =
        CameraPosition(target: _currentLatLing, zoom: cameraZoom);
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
  }

  LocationService locService = new LocationService();
  List<LocationModel> locList;
  Future loadListLocationsWithLatLngAndDistacne(
      double currentlati, double currentLong, double radius) {
    if (locList == null) {
      locList = [];
    }
    Future<List<LocationModel>> futureCases = locService
        .getLocationsWithLatLngAndDistacne(currentlati, currentLong, radius);
    futureCases.then((list) {
      if (this.mounted) {
        setState(() {
          this.locList = list;
        });
      }
    });
    return futureCases;
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
            body: (widget.userModel == null)
                ? LoginValid(
                    currentIndex: 1,
                    content: "Vui lòng đăng nhập để thuê xe!",
                  )
                : Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    "Địa điểm của bạn: ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color:
                                                            my_colors.primary),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    _currentAddress,
                                                    style:
                                                        TextStyle(fontSize: 15),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: my_colors
                                                              .primary),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      _bikeGetAddress,
                                                      style: TextStyle(
                                                          fontSize: 15),
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
                                        helper.pushInto(
                                          context,
                                          RentBikeFilter(
                                            userModel: widget.userModel,
                                            bikeTypeModel: widget.bikeTypeModel,
                                            payPackageModel:
                                                widget.payPackageModel,
                                            locationModel: _locationModel,
                                          ),
                                          true,
                                        );
                                      },
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
            title: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Những điểm nhận xe gần bạn khoảng 1km",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: my_colors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 5),
                // loop cái card thôi
                FutureBuilder(
                  future: loadListLocationsWithLatLngAndDistacne(
                    _currentLatLing.latitude,
                    _currentLatLing.longitude,
                    1,
                  ),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: locList == null ? 0 : locList.length,
                      itemBuilder: (BuildContext context, int index) {
                        LocationModel item = locList[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: InkWell(
                            onTap: () {
                              _locationModel = item;
                              double lati = double.parse(item.latitude);
                              double long = double.parse(item.longitude);
                              getLocation(LatLng(lati, long));
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
                                      item.name,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
