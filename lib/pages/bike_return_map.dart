import 'dart:async';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/tracking_booking.dart';
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

class BikeReturnMap extends StatefulWidget {
  final UserModel userModel;
  final LocationModel locationModel;
  BikeReturnMap({Key key, this.userModel, this.locationModel})
      : super(key: key);

  @override
  _BikeReturnMapState createState() => _BikeReturnMapState();
}

class _BikeReturnMapState extends State<BikeReturnMap> {
  static double _latitude = 10.841493;
  static double _longitude = 106.810038;
  String _bikeReturnAddress = "";
  String _currentAddress = "";
  static double cameraZoom = 15;
  LatLng _currentLatLing;
  bool _isLoadListLocation = false;
  LocationModel _bikeReturnLocationModel;

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
          this._bikeReturnAddress = add1;
        });
      });
      if (_inLatLing != null) {
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
            this._bikeReturnAddress = add2;
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
      _bikeReturnLocationModel = LocationModel(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
    });
    LatLng tmp;
    if (widget.locationModel != null) {
      double lati = double.parse(widget.locationModel.latitude);
      double long = double.parse(widget.locationModel.longitude);
      tmp = LatLng(lati, long);
    }
    getLocation(tmp);
    _initialCameraPosition =
        CameraPosition(target: _currentLatLing, zoom: cameraZoom);
  }

  void _onMapCreated(GoogleMapController _controller) {
    _ggMapController.complete(_controller);

    setState(() {
      getCurrentLocation();
    });
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
          _isLoadListLocation = true;
        });
      }
    });
    return futureCases;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bikeReturnLocationModel = widget.locationModel;
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
                titles: "Chọn vị trí trả xe",
                isShowBackBtn: true,
                bottomAppBar: null,
                onPressedBackBtn: () {
                  helper.pushInto(
                    context,
                    TrackingBooking(
                      userModel: widget.userModel,
                      locationModel: widget.locationModel,
                      isCustomer: true,
                      tabIndex: 0,
                      isShowBackBtn: false,
                    ),
                    false,
                  );
                }),
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
                  ExpandChild(
                    arrowColor: my_colors.primary,
                    arrowSize: 50,
                    expandedHint: "Xem thêm",
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
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
                          if (_bikeReturnAddress.isNotEmpty)
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
                                            "Địa điểm nhận xe: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: my_colors.primary),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _bikeReturnAddress,
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
                    ),
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
                              onPressedElavateBtn: () {
                                helper.pushInto(
                                  context,
                                  TrackingBooking(
                                    userModel: widget.userModel,
                                    isCustomer: true,
                                    tabIndex: 0,
                                    isShowBackBtn: false,
                                    locationModel: _bikeReturnLocationModel,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: IconButton(
                                icon: Image.asset(
                                    'lib/assets/images/location.png'),
                                iconSize: 35,
                                onPressed: getCurrentLocation,
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(
              bottomBarIndex: 3,
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
                        if (!_isLoadListLocation) {
                          return Center(
                            child: Text(
                              "Đang tải . . .",
                              style: TextStyle(
                                fontSize: 20,
                                color: my_colors.primary,
                              ),
                            ),
                          );
                        } else {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5),
                            child: InkWell(
                              onTap: () {
                                _bikeReturnLocationModel = item;
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
                        }
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
