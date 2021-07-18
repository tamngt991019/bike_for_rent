import 'dart:async';

import 'package:bike_for_rent/main.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/payment_model.dart';
import 'package:bike_for_rent/models/payment_type_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_return_map.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/rent_bike_manager.dart';
import 'package:bike_for_rent/services/bike_service.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/services/location_service.dart';
import 'package:bike_for_rent/services/payment_service.dart';
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
import 'package:intl/intl.dart';

// import 'package:dropdown_plus/dropdown_plus.dart';

class TrackingBooking extends StatefulWidget {
  final UserModel userModel;
  final BookingModel bookingModel;
  final LocationModel locationModel;
  final bool isCustomer;
  final bool isShowBackBtn;
  final int tabIndex;
  TrackingBooking({
    Key key,
    this.userModel,
    this.bookingModel,
    this.locationModel,
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
  Future loadListCustomerTrackingBooking() {
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

  Future loadListOwnerTrackingBooking() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<List<BookingModel>> futureCase =
        bookingService.getOwnerBookingsTracking(widget.userModel.username);
    futureCase.then((list) {
      setState(() {
        mainBooking = list.first;
        _isLoadThisScreen = true;
      });
    });
    return futureCase;
  }

  Future getOwnerTrackingBookingById() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<BookingModel> futureCase =
        bookingService.getTrackingBookingById(widget.bookingModel.id);
    futureCase.then((model) {
      setState(() {
        mainBooking = model;
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

  void updateBookingEventType(BookingModel model) {
    Future<bool> futureCase =
        bookingService.updateBookingModel(model.id, model);
    futureCase.then((isUpdateSuccess) {
      if (!isUpdateSuccess) {
        showNotificationDialog(
          "Cảnh bảo!",
          "Thao tác thất bại, vui lòng thử lại!",
          my_colors.danger,
        );
      }
    });
  }

  BikeService bikeService = new BikeService();
  void updateBikeIsBooking(bool isBooking, BookingModel bookingModel) {
    mainBooking.bikeModel.isBooking = isBooking;
    Future<bool> futureCase = bikeService.updateBikeModel(
        mainBooking.bikeModel.id, mainBooking.bikeModel);
    futureCase.then((isUpdateSuccess) {
      if (!isUpdateSuccess) {
        showNotificationDialog(
          "Cảnh bảo!",
          "Thao tác thất bại, vui lòng thử lại!",
          my_colors.danger,
        );
      } else {
        updateBookingEventType(bookingModel);
      }
    });
  }

  double totalPrice = 0;
  bool _isCreatePaymentSuccess = false;
  PaymentService paymentService = new PaymentService();
  void createPayment(String paymentTypeId, String bookingId) {
    Future<PaymentModel> futureCase = paymentService.createPayment(
      PaymentModel(
        paymentTypeId: paymentTypeId,
        bookingId: bookingId,
        totalPrice: totalPrice,
      ),
    );
    futureCase.then((model) {
      if (model != null) {
        _isCreatePaymentSuccess = true;
      } else {
        showNotificationDialog(
          "Cảnh bảo!",
          "Thao tác thất bại, vui lòng thử lại!",
          my_colors.danger,
        );
      }
    });
  }

  String getAvatarStr() {
    if (widget.isCustomer) {
      return mainBooking.bikeModel.userModel.avatar;
    } else {
      return mainBooking.userModel.avatar;
    }
  }

  String getFullnameStr() {
    if (widget.isCustomer) {
      return mainBooking.bikeModel.userModel.fullName;
    } else {
      return mainBooking.userModel.fullName;
    }
  }

  String getPhoneStr() {
    if (widget.isCustomer) {
      return mainBooking.bikeModel.userModel.phone;
    } else {
      return mainBooking.userModel.phone;
    }
  }

  LocationModel _bikeReturnLocationModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if(widget.bookingModel.locationReturnBikeModel != null){

    // }
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
    _ggMapControllerReturn.complete(_controller);
    setState(() {
      double lati = double.parse(widget.locationModel.latitude);
      double long = double.parse(widget.locationModel.longitude);
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
          titles: ((widget.isCustomer) ? "" : "cho ") + "thuê xe",
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
              future: (widget.isCustomer)
                  ? loadListCustomerTrackingBooking()
                  : getOwnerTrackingBookingById(),
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
                              backgroundImage: (mainBooking.bikeModel != null &&
                                      mainBooking.userModel != null)
                                  ? NetworkImage(getAvatarStr())
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
                                    getFullnameStr(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Số điện thoại: " + getPhoneStr(),
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
                        false,
                      ),
                      SizedBox(height: 10),
                      // Bike Return Location
                      if (_bikeReturnLocationModel != null)
                        InkWell(
                          onTap: () {
                            if (widget.userModel.username ==
                                mainBooking.userName)
                              helper.pushInto(
                                context,
                                BikeReturnMap(
                                  userModel: widget.userModel,
                                  locationModel: widget.locationModel,
                                ),
                                true,
                              );
                          },
                          child: getLocationWidget(
                            "Địa điểm " +
                                ((widget.isCustomer) ? "trả" : "lấy") +
                                " xe:",
                            _bikeReturnAddress,
                            _initialCameraPositionReturn,
                            _markersReturn,
                            _onMapCreatedReturn,
                            true,
                          ),
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
                            // thời gian thuê
                            if (mainBooking.eventTypeId == "ARERENTING" ||
                                mainBooking.eventTypeId == "OWNGOTBIKE" ||
                                mainBooking.eventTypeId == "CUSRETURNBIKE" ||
                                mainBooking.eventTypeId == "PAYING")
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Ngày giờ thuê: ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Expanded(
                                        child: Text(
                                            helper.getDateFormatStr(
                                                mainBooking.dateBegin),
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                  if (mainBooking.dateEnd == null)
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Ngày giờ hiện tại: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Expanded(
                                              child: Text(
                                                helper.getDateFormatStr(
                                                  // mainBooking.dateBegin,
                                                  DateTime.now().toString(),
                                                ),
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  //Ngày giờ trả xe
                                  if (mainBooking.dateEnd != null)
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Ngày giờ trả xe: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Expanded(
                                              child: Text(
                                                helper.getDateFormatStr(
                                                    mainBooking.dateEnd),
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Thời gian thuê: ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(
                                          helper
                                              .getDayElapsed(
                                                // mainBooking.dateCreated,
                                                mainBooking.dateBegin,
                                                (mainBooking.dateEnd != null)
                                                    ? mainBooking.dateEnd
                                                    : DateTime.now().toString(),
                                              )
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
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

                            // Tổng tiền
                            if (mainBooking.eventTypeId == "ARERENTING" ||
                                mainBooking.eventTypeId == "OWNGOTBIKE" ||
                                mainBooking.eventTypeId == "CUSRETURNBIKE" ||
                                mainBooking.eventTypeId == "PAYING")
                              Column(
                                children: [
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          helper.getPriceTotalStr(
                                                mainBooking.dateBegin,
                                                (mainBooking.dateEnd != null)
                                                    ? mainBooking.dateEnd
                                                    : DateTime.now().toString(),
                                                mainBooking
                                                    .bikeModel.bikeTypeModel.id,
                                                mainBooking.payPackageModel,
                                              ) +
                                              " VND",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (mainBooking.eventTypeId == "OWNGOTBIKE")
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      if (widget.isCustomer)
                        Column(
                          children: [
                            //Đồng ý - huỷ
                            if (mainBooking.eventTypeId == "OWNSHIPPEDBIKE")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElavateBtn(
                                    width: 180,
                                    title: 'Đồng ý thuê xe',
                                    onPressedElavateBtn: () {
                                      setState(() {
                                        BookingModel tmpModel = mainBooking;
                                        tmpModel.dateBegin =
                                            DateTime.now().toIso8601String();
                                        tmpModel.eventTypeId = "ARERENTING";
                                        updateBikeIsBooking(true, tmpModel);
                                        // mainBooking.eventTypeId = "ARERENTING";
                                        // updateBookingEventType("ARERENTING");
                                      });
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  OutlineBtn(
                                    width: 180,
                                    title: 'Hủy thuê xe',
                                    onPressedOutlineBtn: () {
                                      setState(() {
                                        BookingModel tmpModel = mainBooking;
                                        tmpModel.eventTypeId = "CANCELED";
                                        updateBookingEventType(tmpModel);
                                      });
                                      showConfirmDialog(
                                        "Huỷ thuê xe",
                                        "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                                        RentBikeManager(
                                          userModel: widget.userModel,
                                          tabIndex: 0,
                                        ),
                                      );
                                      showConfirmDialog(
                                        "Tiếp tục thuê?",
                                        "Bạn có muốn tiếp tục thuê không?",
                                        Home(userModel: widget.userModel),
                                      );
                                    },
                                  )
                                ],
                              ),
                            // chọn điểm trả xe - Yêu cầu trả xe
                            if (mainBooking.eventTypeId == "ARERENTING")
                              Column(
                                children: [
                                  // chọn điểm trả xe
                                  SizedBox(
                                    width: 380,
                                    height: 45,
                                    child: InkWell(
                                      onTap: () {
                                        helper.pushInto(
                                          context,
                                          BikeReturnMap(
                                            userModel: widget.userModel,
                                            locationModel: widget.locationModel,
                                          ),
                                          true,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: my_colors.primary,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Chọn vị trí trả xe',
                                            style: TextStyle(
                                              color: my_colors.primary,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (widget.locationModel != null)
                                    SizedBox(height: 15),
                                  //Yêu cầu trả xe
                                  if (widget.locationModel != null)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 380,
                                          title: 'Yêu cầu trả xe',
                                          onPressedElavateBtn: () {
                                            setState(() {
                                              if (widget.locationModel !=
                                                  null) {
                                                BookingModel tmpModel =
                                                    mainBooking;
                                                // KIỂM TRA LOCATION TRẢ XE Ở ĐÂY
                                                tmpModel.dateEnd =
                                                    DateTime.now()
                                                        .toIso8601String();
                                                tmpModel.eventTypeId =
                                                    "CUSRETURNBIKE";
                                                updateBookingEventType(
                                                    tmpModel);
                                              }
                                            });
                                          },
                                        )
                                      ],
                                    ),
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
                                      bool isPaymentTypeChange =
                                          _paymentTypeStr ==
                                              "Chọn hình thức thanh toán:";
                                      if (isPaymentTypeChange) {
                                        setState(() {
                                          // mainBooking.eventTypeId = "PAYING";
                                          BookingModel tmpModel = mainBooking;
                                          tmpModel.eventTypeId = "PAYING";
                                          updateBookingEventType(tmpModel);
                                          // updateBookingEventType("PAYING");s
                                        });
                                      } else {
                                        showNotificationDialog(
                                          "Cảnh báo!",
                                          "Vui lòng chọn hình thức thuê xe!",
                                          my_colors.danger,
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                          ],
                        ),
                      // các nút của chủ xe
                      if (!widget.isCustomer)
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
                                        // mainBooking.eventTypeId =
                                        //     "OWNSHIPPINGBIKE";
                                        BookingModel tmpModel = mainBooking;
                                        tmpModel.eventTypeId =
                                            "OWNSHIPPINGBIKE";
                                        updateBookingEventType(tmpModel);
                                        // updateBookingEventType(
                                        //     "OWNSHIPPINGBIKE");
                                      });
                                    },
                                  ),
                                  SizedBox(width: 20),
                                  OutlineBtn(
                                    width: 180,
                                    title: 'Từ chối cho thuê',
                                    onPressedOutlineBtn: () {
                                      setState(() {
                                        // mainBooking.eventTypeId = "CANCELED";
                                        BookingModel tmpModel = mainBooking;
                                        tmpModel.eventTypeId = "CANCELED";
                                        updateBookingEventType(tmpModel);
                                        // updateBookingEventType("CANCELED");
                                      });
                                      showConfirmDialog(
                                        "Từ chối cho thuê",
                                        "Bạn có muốn từ chối yêu cầu thuê này không?",
                                        RentBikeManager(
                                          userModel: widget.userModel,
                                          tabIndex: 0,
                                        ),
                                      );
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
                                        // mainBooking.eventTypeId =
                                        //     "OWNSHIPPEDBIKE";
                                        BookingModel tmpModel = mainBooking;
                                        tmpModel.eventTypeId = "OWNSHIPPEDBIKE";
                                        updateBookingEventType(tmpModel);
                                        // updateBookingEventType(
                                        //     "OWNSHIPPEDBIKE");
                                      });
                                    },
                                  ),
                                ],
                              ),
                            if (mainBooking.eventTypeId == "CUSRETURNBIKE")
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElavateBtn(
                                    width: 380,
                                    title: 'Đã lấy xe',
                                    onPressedElavateBtn: () {
                                      setState(() {
                                        // mainBooking.eventTypeId = "OWNGOTBIKE";
                                        BookingModel tmpModel = mainBooking;
                                        tmpModel.eventTypeId = "OWNGOTBIKE";
                                        updateBookingEventType(tmpModel);
                                        // updateBookingEventType("OWNGOTBIKE");
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
                                        // updateBikeIsBooking(
                                        //     false, "ARERENTING");
                                        // mainBooking.eventTypeId = "FINISHED";
                                        createPayment(
                                          _paymentTypeModel.id,
                                          mainBooking.id,
                                        );
                                        if (_isCreatePaymentSuccess) {
                                          BookingModel tmpModel = mainBooking;
                                          tmpModel.eventTypeId = "FINISHED";
                                          updateBikeIsBooking(true, tmpModel);
                                          // updateBookingEventType("FINISHED");
                                        }
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

  dynamic showConfirmDialog(
      String titleStr, String contentStr, Widget confirmWidget) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            titleStr,
            style: TextStyle(fontSize: 20),
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
                helper.pushInto(context, confirmWidget, false);
              },
            ),
            TextButton(
              child: Text(
                "Huỷ",
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
    Function(GoogleMapController) onMapCreated,
    bool isReturn,
  ) {
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
            onTap: (val) {
              if (isReturn) {
                helper.pushInto(
                  context,
                  BikeReturnMap(
                    userModel: widget.userModel,
                    locationModel: widget.locationModel,
                  ),
                  true,
                );
              }
            },
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
