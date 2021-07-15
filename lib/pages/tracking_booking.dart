import 'dart:async';

import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/payment_type_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_manager.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/services/location_service.dart';
import 'package:bike_for_rent/services/payment_type_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:bike_for_rent/widgets/notification_dialog.dart';
import 'package:bike_for_rent/widgets/outline_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:dropdown_plus/dropdown_plus.dart';

class TrackingBooking extends StatefulWidget {
  final UserModel userModel;
  // final BookingModel bookingModel;
  final bool isCustomer;
  final bool isShowBackBtn;
  final int tabIndex;
  TrackingBooking({
    Key key,
    this.userModel,
    // this.bookingModel,
    this.isCustomer,
    this.isShowBackBtn,
    this.tabIndex,
  }) : super(key: key);

  @override
  _TrackingBookingState createState() => _TrackingBookingState();
}

class _TrackingBookingState extends State<TrackingBooking> {
  // Bike type dropdown ---------------------------------
  String _paymentTypeStr = "Chọn hình thức thanh toán:";
  Color _paymentTypeColor = Colors.grey[700];
  String _paymentTypeIdSelected = "";

  bool _isLoadThisScreen = false;

  List<String> imageUrls() {
    List<String> imageUrls = [
      "https://media.publit.io/file/BikeForRent/banner/banner1.jpg",
      "https://media.publit.io/file/BikeForRent/banner/banner2.jpg",
      "https://media.publit.io/file/BikeForRent/banner/banner3.jpg",
      "https://media.publit.io/file/BikeForRent/banner/banner4.jpg",
      "https://media.publit.io/file/BikeForRent/banner/banner5.jpg",
    ];
    return imageUrls;
  }

  BookingService bookingService = new BookingService();
  BookingModel mainBooking;
  Future loadListTrackingBooking() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<List<BookingModel>> futureCase =
        bookingService.getCustomerBookingsTracking(widget.userModel.username);
    futureCase.then((list) {
      setState(() {
        mainBooking = list.first;
        _isLoadThisScreen = true;
      });
    });
    return futureCase;
  }

  PaymentTypeService paymentTypeService = new PaymentTypeService();
  PaymentTypeModel _paymentTypeModel;
  List<PaymentTypeModel> paymentTypeList;
  Future loadListPaymentTypes() {
    if (paymentTypeList == null) {
      paymentTypeList = [];
    }
    Future<List<PaymentTypeModel>> futureCase =
        paymentTypeService.getPaymentTypeModels();
    futureCase.then((list) {
      setState(() {
        paymentTypeList = list;
      });
    });
    return futureCase;
  }

  // LocationService locService = new LocationService();
  // LocationModel _locationModel;
  // void getLocationById(String id) {
  //   if (_locationModel == null) {
  //     this._locationModel = new LocationModel();
  //   }
  //   Future<LocationModel> futureCases = locService.getLocationById(id);
  //   futureCases.then((model) {
  //     if (this.mounted) {
  //       setState(() {
  //         _locationModel = model;
  //         locLati = double.parse(_locationModel.latitude);
  //         locLong = double.parse(_locationModel.longitude);
  //         _latLng = LatLng(locLati, locLong);
  //         getLocation(_latLng);
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //========================================================================
  // GG Map
  static double cameraZoom = 15;
  //========================================================================
  // Map Get Location
  String _bikeGetAddress = "";
  CameraPosition _initialCameraPositionGet = CameraPosition(
    target: LatLng(10.82414068863801, 106.63065063707423),
    zoom: cameraZoom,
  );
  Completer<GoogleMapController> _ggMapControllerGet = Completer();
  Set<Marker> _markersGet = {};
  // on map create Get
  void _onMapCreatedGet(GoogleMapController _controller) {
    _ggMapControllerGet.complete(_controller);
    setState(() {
      double lati = double.parse(mainBooking.locationGetBikeModel.latitude);
      double long = double.parse(mainBooking.locationGetBikeModel.longitude);
      getLocation(
        LatLng(lati, long),
        _markersGet,
        _initialCameraPositionGet,
        _ggMapControllerGet,
        true,
      );
    });
  }

  //========================================================================
  // Return Get Location
  String _bikeReturnAddress = "";
  CameraPosition _initialCameraPositionReturn = CameraPosition(
    target: LatLng(10.82414068863801, 106.63065063707423),
    zoom: cameraZoom,
  );
  Completer<GoogleMapController> _ggMapControllerReturn = Completer();
  Set<Marker> _markersReturn = {};
  void _onMapCreatedReturn(GoogleMapController _controller) {
    _ggMapControllerGet.complete(_controller);
    setState(() {
      double lati = double.parse(mainBooking.locationReturnBikeModel.latitude);
      double long = double.parse(mainBooking.locationReturnBikeModel.longitude);
      getLocation(
        LatLng(lati, long),
        _markersReturn,
        _initialCameraPositionReturn,
        _ggMapControllerReturn,
        false,
      );
    });
  }

//========================================================================
  void moveCamera(CameraPosition cameraPosition,
      Completer<GoogleMapController> ggController) async {
    final GoogleMapController controller = await ggController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      cameraPosition,
    ));
  }

  Future<String> getAddress(double _inLatitude, double _inLongitude) async {
    final coordinates = new Coordinates(_inLatitude, _inLongitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine;
  }

  void getLocation(
      LatLng _inLatLing,
      Set<Marker> markers,
      CameraPosition cameraPosition,
      Completer<GoogleMapController> ggController,
      bool isGetAddress) {
    setState(() {
      // _markers.
      markers.clear();

      markers.add(
        Marker(
          markerId: MarkerId("ID-1"),
          position: _inLatLing,
        ),
      );
      getAddress(_inLatLing.latitude, _inLatLing.longitude).then((add) {
        setState(() {
          if (isGetAddress) {
            _bikeGetAddress = add;
          } else {
            _bikeReturnAddress = add;
          }
        });
      });
      cameraPosition = CameraPosition(target: _inLatLing, zoom: cameraZoom);
      moveCamera(cameraPosition, ggController);
    });
  }

//========================================================================
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
          isShowBackBtn: (widget.isCustomer) ? false : widget.isShowBackBtn,
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
            context,
            RentBikeManager(
              userModel: widget.userModel,
              tabIndex: widget.tabIndex,
            ),
            false,
          ),
        ),
        // Body app
        body: Center(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: loadListTrackingBooking(),
              builder: (context, snapshot) {
                if (!_isLoadThisScreen) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đang tải . . .",
                        style: TextStyle(
                          fontSize: 20,
                          color: my_colors.primary,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      // Ten người dùng, sđt, avatar
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // avatar
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: (mainBooking
                                          .bikeModel.userModel.fullName !=
                                      null)
                                  ? NetworkImage(
                                      mainBooking.bikeModel.userModel.avatar)
                                  : AssetImage(
                                      "lib/assets/images/avatar_logo.png",
                                    ),
                            ),
                            SizedBox(width: 20),
                            // tên người dùng và sđt
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // tên người dùng
                                  Text(
                                    (!widget.isCustomer)
                                        ? widget.userModel.fullName
                                        : mainBooking
                                            .bikeModel.userModel.fullName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // sđt
                                  if (mainBooking.bikeModel.userModel.phone !=
                                      null)
                                    Text(
                                      "Số điện thoại: " +
                                          mainBooking.bikeModel.userModel.phone,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //=======================================================
                      // hình ảnh xe
                      ImageSlideshow(
                        width: double.infinity,
                        height: 250,
                        initialPage: 0,
                        indicatorColor: my_colors.primary,
                        indicatorBackgroundColor: Colors.white,
                        children: imageUrls()
                            .map((img) => ClipRRect(
                                child: Image.network(img, fit: BoxFit.cover)))
                            .toList(),
                        onPageChanged: (value) {},
                        autoPlayInterval: 60000,
                      ),
                      // Thông tin xe
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Bookingdetail(
                          bikeModel: mainBooking.bikeModel,
                          bookingModel: mainBooking,
                          isCustomerHistory: false,
                          isCustomerHistoryDetail: false,
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        endIndent: 15,
                        indent: 15,
                        color: Colors.black,
                      ),
                      //=======================================================
                      // Thông tin địa điểm
                      // Bike Get Location
                      getLocationWidget(
                        "Địa điểm " +
                            ((widget.isCustomer) ? "nhận" : "giao") +
                            " xe:",
                        _bikeGetAddress,
                        _initialCameraPositionGet,
                        _markersGet,
                        _onMapCreatedGet,
                      ),
                      SizedBox(height: 10),
                      // Bike Return Location
                      if (mainBooking.locationReturnBike != null &&
                          mainBooking.locationReturnBikeModel != null)
                        getLocationWidget(
                          "Địa điểm " +
                              ((widget.isCustomer) ? "trả" : "lấy") +
                              " xe:",
                          _bikeReturnAddress,
                          _initialCameraPositionReturn,
                          _markersReturn,
                          _onMapCreatedReturn,
                        ),
                      //=======================================================
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        endIndent: 15,
                        indent: 15,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 15, left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // tiêu đề
                            Text(
                              "Thông tin khác: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // gói thuê
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gói thuê: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(mainBooking.payPackageModel.name,
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // thời gian thuê
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Thời gian thuê: ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Expanded(
                                  child: Text("Đang tính . . .",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // trạng thái
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Trạng thái: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    mainBooking.eventTypeModel.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: my_colors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Tổng tiền
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tổng tiền: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "123456 vnd",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Thanh toán
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Thanh toán: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                showDropdownPaymentType(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _paymentTypeStr,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: _paymentTypeColor,
                                        ),
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
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        endIndent: 15,
                        indent: 15,
                        color: Colors.black,
                      ),
                      SizedBox(height: 15),
                      // Các nút cập nhật trạng thái của booking
                      // các nút của người thuê
                      // if (widget.isCustomer)
                      Column(
                        children: [
                          if (mainBooking.eventTypeId == "OWNSHIPPEDBIKE")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 180,
                                  title: 'Đã nhận xe',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "ARERENTING";
                                    });
                                  },
                                ),
                                SizedBox(width: 20),
                                OutlineBtn(
                                  width: 180,
                                  title: 'Hủy thuê xe',
                                  onPressedOutlineBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "CANCELED";
                                    });

                                    // showConfirmDialog(
                                    //   "Huỷ thuê xe",
                                    //   "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                                    //   RentBikeManager(
                                    //     userModel: widget.userModel,
                                    //     tabIndex: 0,
                                    //   ),
                                    //   null,
                                    // );
                                  },
                                )
                              ],
                            ),
                          if (mainBooking.eventTypeId == "ARERENTING")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 380,
                                  title: 'Yêu cầu trả xe',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "CUSRETURNBIKE";
                                    });
                                  },
                                )
                              ],
                            ),
                          if (mainBooking.eventTypeId == "OWNGOTBIKE")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 380,
                                  title: 'Thanh toán',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "PAYING";
                                    });
                                  },
                                )
                              ],
                            ),
                        ],
                      ),
                      // các nút của chủ xe
                      // if (!widget.isCustomer)
                      Column(
                        children: [
                          if (mainBooking.eventTypeId == "PROCESSING")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 180,
                                  title: 'Đồng ý cho thuê',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId =
                                          "OWNSHIPPINGBIKE";
                                    });
                                  },
                                ),
                                SizedBox(width: 20),
                                OutlineBtn(
                                  width: 180,
                                  title: 'Từ chối cho thuê',
                                  onPressedOutlineBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "CANCELED";
                                    });

                                    // showConfirmDialog(
                                    //   "Từ chối cho thuê",
                                    //   "Bạn có muốn từ chối yêu cầu thuê này không?",
                                    //   RentBikeManager(
                                    //     userModel: widget.userModel,
                                    //     tabIndex: 0,
                                    //   ),
                                    //   null,
                                    // );
                                    // showConfirmDialog(
                                    //   "Huỷ thuê xe",
                                    //   "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                                    //   RentBikeManager(
                                    //     userModel: widget.userModel,
                                    //     tabIndex: 0,
                                    //   ),
                                    // );
                                  },
                                ),
                              ],
                            ),
                          if (mainBooking.eventTypeId == "OWNSHIPPINGBIKE")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 380,
                                  title: 'Đã giao xe',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId =
                                          "OWNSHIPPEDBIKE";
                                    });
                                  },
                                ),
                              ],
                            ),
                          // if (mainBooking.eventTypeId == "OWNSHIPPINGBIKE")
                          //   Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       ElavateBtn(
                          //         width: 380,
                          //         title: 'Đã giao xe',
                          //         onPressedElavateBtn: () {
                          //           mainBooking.eventTypeId = "OWNSHIPPEDBIKE";
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          if (mainBooking.eventTypeId == "CUSRETURNBIKE")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 380,
                                  title: 'Đã lấy xe',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "OWNGOTBIKE";
                                    });
                                  },
                                ),
                              ],
                            ),
                          if (mainBooking.eventTypeId == "PAYING")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 380,
                                  title: 'Xác nhận thanh toán',
                                  onPressedElavateBtn: () {
                                    setState(() {
                                      mainBooking.eventTypeId = "PROCESSING";
                                    });
                                  },
                                )
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: 15),
                      //===========================================
                    ],
                  );
                }
              },
            ),
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: (widget.isCustomer) ? 1 : 3,
          userModel: widget.userModel,
        ),
      ),
    );
  }

  // dynamic showConfirmDialog(String titleStr, String contentStr,
  //     Widget confirmWidget1, Widget confirmWidget2) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext dialogContext) {
  //       return AlertDialog(
  //         title: Text(
  //           titleStr,
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         content: Text(
  //           contentStr,
  //           style: TextStyle(fontSize: 17),
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         elevation: 5,
  //         actions: [
  //           TextButton(
  //             child: Text(
  //               "Đồng ý",
  //               style: TextStyle(fontSize: 15),
  //             ),
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //               helper.pushInto(context, confirmWidget1, false);
  //             },
  //           ),
  //           TextButton(
  //             child: Text(
  //               "Huỷ",
  //               style: TextStyle(fontSize: 15),
  //             ),
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  dynamic showDropdownPaymentType(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Chọn hình thức thanh toán:",
            style: TextStyle(fontSize: 20),
          ),
          content: Container(
            width: 1, // Cho nay khai bao de khong bi loi - Ly do : chua biet
            height: 100,
            child: FutureBuilder(
              future: loadListPaymentTypes(),
              builder: (dialogContext, snapshot) {
                return ListView.builder(
                  itemCount:
                      paymentTypeList == null ? 0 : paymentTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = paymentTypeList[index];
                    return TextButton(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: (_paymentTypeModel != null &&
                                  item.id == _paymentTypeIdSelected)
                              ? my_colors.primary
                              : Colors.black,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (item.id == "MOMO") {
                            Navigator.pop(context);
                            showNotificationDialog(
                              "Thông báo!",
                              "Chưa hỗ trợ phương thức thanh toán này!",
                              my_colors.primary,
                            );
                          } else {
                            _paymentTypeIdSelected = item.id;
                            _paymentTypeStr = item.name;
                            _paymentTypeColor = Colors.black;
                            _paymentTypeModel = item;
                            Navigator.pop(context);
                          }
                        });
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

  // hien thi thong bao
  dynamic showNotificationDialog(
      String titleStr, String contentStr, Color titleCColor) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return NotificationDialog(
          title: titleStr,
          titleColor: titleCColor,
          content: contentStr,
        );
      },
    );
  }

  Widget getLocationWidget(
      String title,
      String address,
      CameraPosition initCamera,
      Set<Marker> markers,
      Function(GoogleMapController) onMapCreated) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FrameText(
                title: title,
                content: address,
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
            initialCameraPosition: initCamera,
            markers: markers,
            onMapCreated: onMapCreated,
          ),
        ),
      ],
    );
  }
}

// BookingModel mainBooking = new BookingModel(
//     id: "5F14BD9C-F388-4F91-8585-6472737E0796",
//     bikeId: "BIKE20",
//     payPackageId: "PPKXS24",
//     dateCreated: "2021-07-14T03:09:36.137",
//     locationGetBike: "HCMLOC5",
//     eventTypeId: "PROCESSING",
//     bikeModel: BikeModel(
//       id: "BIKE20",
//       username: "owner2",
//       brandId: "BRAND1",
//       model: "SIRIUS",
//       color: "Đen",
//       licensePlates: "52X1-345.67",
//       typeId: "XS",
//       locationId: "OWNERLOC2",
//       isBooking: false,
//       isRentingEnable: true,
//       status: "ACTIVE",
//       bikeTypeModel: BikeTypeModel(
//         id: "XS",
//         name: "Xe số",
//       ),
//       bikeBrandModel: BikeBrandModel(
//         id: "BRAND1",
//         name: "Yamaha",
//       ),
//       listBikeImage: [],
//     ),
//     eventTypeModel: EventTypeModel(
//       id: "PROCESSING",
//       name: "Đang xử lý",
//     ),
//     locationGetBikeModel: LocationModel(
//         id: "HCMLOC5",
//         name: "KFC Hiệp Bình",
//         address:
//             "173 đường Hiệp Bình, Hiệp Bình Chánh, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam",
//         areaId: "AHCM01",
//         locationTypeId: "LOCTY9",
//         latitude: "10.842592143108645",
//         longitude: "106.73129533471955",
//         isShipPoint: true),
//     payPackageModel: PayPackageModel(
//         id: "PPKXS24",
//         name: "100000 / 24 giờ",
//         description: "Giá xe số 24 giờ",
//         price: 100000,
//         bikeTypeId: "XS"),
//   );
