import 'dart:async';

import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_get_map.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/pages/rent_bike_list.dart';
import 'package:bike_for_rent/services/bike_type_service.dart';
import 'package:bike_for_rent/services/location_service.dart';
import 'package:bike_for_rent/services/pay_package_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;

class RentBikeFilter extends StatefulWidget {
  final UserModel userModel;
  final BikeTypeModel bikeTypeModel;
  final LocationModel locationModel;
  final PayPackageModel payPackageModel;
  RentBikeFilter({
    Key key,
    this.userModel,
    this.bikeTypeModel,
    this.locationModel,
    this.payPackageModel,
  }) : super(key: key);

  @override
  _RentBikeFilterState createState() => _RentBikeFilterState();
}

class _RentBikeFilterState extends State<RentBikeFilter> {
  String _bikeGetAddress = "";
  // Bike type dropdown ---------------------------------
  String _bikeTypeStr = "Chọn loại xe:";
  Color _bikeTypeColor = Colors.grey[700];
  String _bikeTypeIdSelected = "";
  // Pay package dropdown ---------------------------------
  // pay package = ppk
  String _ppkStr = "Chọn gói thuê:";
  Color _ppkColor = Colors.grey[700];
  String _ppkIdSelected = "";
  // Location lati, long ---------------------------------
  double locLati = 10.841493;
  double locLong = 106.810038;
  // Map ---------------------------------
  LatLng _latLng; //= LatLng(locLati, locLong);
  //============================================================================

  BikeTypeService bikeTypeService = new BikeTypeService();
  List<BikeTypeModel> bikeTypeList;
  Future loadListBikeTypes() {
    if (bikeTypeList == null) {
      bikeTypeList = [];
    }
    Future<List<BikeTypeModel>> futureCases =
        bikeTypeService.getBikeTypeModels();
    futureCases.then((list) {
      if (this.mounted) {
        setState(() {
          this.bikeTypeList = list;
        });
      }
    });
    return futureCases;
  }

  BikeTypeModel _bikeTypeModel;
  void getBikeTypeById(String id) {
    if (_bikeTypeModel == null) {
      this._bikeTypeModel = new BikeTypeModel();
    }
    Future<BikeTypeModel> futureCases = bikeTypeService.getBikeTypeById(id);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          _bikeTypeModel = model;
          _bikeTypeStr = _bikeTypeModel.name;
        });
      }
    });
  }

  PayPackageService ppkService = new PayPackageService();
  List<PayPackageModel> ppkList;
  Future loadListPayPackages() {
    if (ppkList == null) {
      ppkList = [];
    }
    Future<List<PayPackageModel>> futureCases =
        ppkService.getPayPackageModels();
    futureCases.then((list) {
      if (this.mounted) {
        setState(() {
          this.ppkList = list;
        });
      }
    });
    return futureCases;
  }

  PayPackageModel _ppkModel;
  void getPayPackageById(String id) {
    if (_ppkModel == null) {
      this._ppkModel = new PayPackageModel();
    }
    Future<PayPackageModel> futureCases = ppkService.getPayPackageById(id);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          _ppkModel = model;
          _ppkStr = _ppkModel.name;
        });
      }
    });
  }

  LocationService locService = new LocationService();
  LocationModel _locationModel;
  void getLocationById(String id) {
    if (_bikeTypeModel == null) {
      this._bikeTypeModel = new BikeTypeModel();
    }
    Future<LocationModel> futureCases = locService.getLocationById(id);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          _locationModel = model;
          locLati = double.parse(_locationModel.latitude);
          locLong = double.parse(_locationModel.longitude);
          _latLng = LatLng(locLati, locLong);
          getLocation(_latLng);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.userModel = new UserModel();

    if (widget.bikeTypeModel != null) {
      _bikeTypeIdSelected = widget.bikeTypeModel.id;
      getBikeTypeById(_bikeTypeIdSelected);
    }
    _ppkModel = widget.payPackageModel;

    if (widget.payPackageModel != null) {
      _ppkIdSelected = widget.payPackageModel.id;
      getPayPackageById(_ppkIdSelected);
    }
    getLocationById(widget.locationModel.id);
  }

  static double cameraZoom = 15;
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

  Future<String> getAddress(double _inLatitude, double _inLongitude) async {
    final coordinates = new Coordinates(_inLatitude, _inLongitude);
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
          position: _inLatLing,
        ),
      );
      getAddress(_inLatLing.latitude, _inLatLing.longitude).then((add1) {
        setState(() {
          this._bikeGetAddress = add1;
        });
      });
      _initialCameraPosition =
          CameraPosition(target: _inLatLing, zoom: cameraZoom);
      moveCamera();
    });
  }

  void _onMapCreated(GoogleMapController _controller) {
    _ggMapController.complete(_controller);

    setState(() {
      getLocation(LatLng(10.82414068863801, 106.63065063707423));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: Appbar(
          height: 50,
          titles: "Thuê xe",
          isShowBackBtn: true,
          onPressedBackBtn: () => helper.pushInto(
              context,
              BikeGetMap(
                userModel: widget.userModel,
                bikeTypeModel: widget.bikeTypeModel,
                payPackageModel: _ppkModel,
              ),
              false),
        ),
        // Body app
        body:
            // (widget.userModel == null)
            //     ? LoginValid(
            //         currentIndex: 1,
            //         content: "Vui lòng đăng nhập để thuê xe!",
            //       )
            //     :
            SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FrameText(
                      title: "Địa điểm nhận xe:",
                      content: _bikeGetAddress,
                    ),
                  ],
                ),
              ),
              // map
              Container(
                height: 250,
                child: GoogleMap(
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: _initialCameraPosition,
                  markers: _markers,
                  onMapCreated: _onMapCreated,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chọn loại xe:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        showDropdownBikeType(context);
                        // showDropdown(
                        //   context,
                        //   "Chọn loại xe:",
                        //   loadListBikeTypes(),
                        //   widget.bikeTypeModel,
                        //   bikeTypeList,
                        //   _bikeTypeIdSelected,
                        //   true,
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _bikeTypeStr,
                                style: TextStyle(
                                    fontSize: 15, color: _bikeTypeColor),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chọn gói thuê: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        showDropdownPayPackage(context);
                        // showDropdown(
                        //   context,
                        //   "Chọn gói thuê:",
                        //   loadListPayPackages(),
                        //   _ppkModel = new PayPackageModel(),
                        //   ppkList,
                        //   _ppkIdSelected,
                        //   false,
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _ppkStr,
                                style:
                                    TextStyle(fontSize: 15, color: _ppkColor),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElavateBtn(
                  width: 380,
                  title: 'Tìm xe',
                  onPressedElavateBtn: () {
                    if (_bikeTypeModel == null && _ppkModel == null) {
                      showWarningDialog(
                        "Vui lòng chọn loại xe và gói thuê xe!",
                      );
                    } else if (_bikeTypeModel == null && _ppkModel != null) {
                      showWarningDialog(
                        "Vui lòng chọn loại xe!",
                      );
                    } else if (_bikeTypeModel != null && _ppkModel == null) {
                      showWarningDialog(
                        "Vui lòng chọn gói thuê xe!",
                      );
                    } else {
                      helper.pushInto(
                          context,
                          RentBikeList(
                            userModel: widget.userModel,
                            bikeTypeModel: _bikeTypeModel,
                            locationModel: _locationModel,
                            payPackageModel: _ppkModel,
                          ),
                          true);
                    }
                  },
                ),
              )
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 1,
          userModel: widget.userModel,
        ),
      ),
    );
  }

  dynamic showDropdownBikeType(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Chọn loại xe",
            style: TextStyle(fontSize: 20),
          ),
          content: Container(
            width: 1, // Cho nay khai bao de khong bi loi - Ly do : chua biet
            height: 100,
            child: FutureBuilder(
              future: loadListBikeTypes(),
              builder: (dialogContext, snapshot) {
                return ListView.builder(
                  itemCount: bikeTypeList == null ? 0 : bikeTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = bikeTypeList[index];
                    return TextButton(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: (_bikeTypeModel != null &&
                                  item.id == _bikeTypeIdSelected)
                              ? my_colors.primary
                              : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _bikeTypeIdSelected = item.id;
                          _bikeTypeStr = item.name;
                          _bikeTypeColor = Colors.black;
                          _bikeTypeModel = item;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  dynamic showDropdownPayPackage(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Chọn gói thuê",
            style: TextStyle(fontSize: 20),
          ),
          content: Container(
            width: 1, // Cho nay khai bao de khong bi loi - Ly do : chua biet
            height: 100,
            child: FutureBuilder(
              future: loadListPayPackages(),
              builder: (dialogContext, snapshot) {
                return ListView.builder(
                  itemCount: ppkList == null ? 0 : ppkList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = ppkList[index];
                    return TextButton(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 15,
                          color:
                              (_ppkModel != null && item.id == _ppkIdSelected)
                                  ? my_colors.primary
                                  : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _ppkIdSelected = item.id;
                          _ppkStr = item.name;
                          _ppkColor = Colors.black;
                          _ppkModel = item;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  dynamic showWarningDialog(String contentStr) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Cảnh báo!",
            style: TextStyle(
              fontSize: 20,
              color: my_colors.danger,
            ),
          ),
          content: Text(
            contentStr,
            style: TextStyle(fontSize: 17),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          actions: [
            TextButton(
              child: Text(
                "Đồng ý",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }
  // dynamic showDropdown(
  //   BuildContext context,
  //   String title,
  //   Future<dynamic> future,
  //   dynamic model,
  //   List<dynamic> list,
  //   String selectedItemId,
  //   bool isBikeType,
  // ) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         title: Text(
  //           title,
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         content: Container(
  //           width: 1, // Cho nay khai bao de khong bi loi - Ly do : chua biet
  //           height: 100,
  //           child: FutureBuilder(
  //             future: future,
  //             builder: (dialogContext, snapshot) {
  //               return ListView.builder(
  //                 itemCount: list == null ? 0 : list.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   var item = list[index];
  //                   return TextButton(
  //                     child: Text(
  //                       item.name,
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: (model != null && item.id == selectedItemId)
  //                             ? my_colors.primary
  //                             : Colors.black,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       setState(() {
  //                         if (isBikeType) {
  //                           _bikeTypeIdSelected = item.id;
  //                           _bikeTypeStr = item.name;
  //                           _bikeTypeColor = Colors.black;
  //                         } else {
  //                           _ppkIdSelected = item.id;
  //                           _ppkStr = item.name;
  //                           _ppkColor = Colors.black;
  //                         }
  //                       });
  //                       Navigator.pop(context);
  //                       // helper.pushInto(context, confirmWidget1, false);
  //                     },
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
