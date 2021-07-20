import 'dart:async';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/payment_model.dart';
import 'package:bike_for_rent/models/payment_type_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_return_map.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/rating.dart';
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
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  dynamic ratingNum = 0.0;
  // String ratingContent = "";
  final ratingContent = TextEditingController();
  // Bike type dropdown ---------------------------------
  String _paymentTypeStr = "Chọn hình thức thanh toán:";
  Color _paymentTypeColor = Colors.grey[700];
  String _paymentTypeIdSelected = "";

  LocationModel returnLocation;
  bool _isLoadThisScreen = false;

  BookingService bookingService = new BookingService();
  BookingModel mainBooking;
  Future loadListCustomerTrackingBooking() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<List<BookingModel>> futureCase =
        bookingService.getCustomerBookingsTracking(
            widget.userModel.username, widget.userModel.token);
    futureCase.then((list) {
      if (this.mounted) {
        setState(() {
          if (list != null && list.length > 0) {
            mainBooking = list.first;
            _isLoadThisScreen = true;
          }
        });
      }
    });
    return futureCase;
  }

  Future loadListOwnerTrackingBooking() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<List<BookingModel>> futureCase =
        bookingService.getOwnerBookingsTracking(
            widget.userModel.username, widget.userModel.token);
    futureCase.then((list) {
      if (this.mounted) {
        setState(() {
          mainBooking = list.first;
          returnLocation = list.first.locationReturnBikeModel;
          _isLoadThisScreen = true;
        });
      }
    });
    return futureCase;
  }

  Future getOwnerTrackingBookingById() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<BookingModel> futureCase = bookingService.getTrackingBookingById(
        widget.bookingModel.id, widget.userModel.token);
    futureCase.then((model) {
      if (this.mounted) {
        setState(() {
          mainBooking = model;
          returnLocation = model.locationReturnBikeModel;
          _isLoadThisScreen = true;
        });
      }
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
        paymentTypeService.getPaymentTypeModels(widget.userModel.token);
    futureCase.then((list) {
      setState(() {
        paymentTypeList = list;
      });
    });
    return futureCase;
  }

  bool _isUpdateBookingSuccess = false;
  void updateBookingEventType(BookingModel model) {
    Future<bool> futureCase = bookingService.updateBookingModel(
        model.id, model, widget.userModel.token);
    futureCase.then((isUpdateSuccess) {
      if (this.mounted) {
        if (!isUpdateSuccess) {
          showNotificationDialog(
            "Cảnh bảo!",
            "Thao tác thất bại, vui lòng thử lại! update even type",
            my_colors.danger,
          );
        } else {
          if (model.eventTypeId == "PAYING" ||
              model.eventTypeId == "FINISHED") {
            _isUpdateBookingSuccess = true;
          }
        }
      }
    });
  }

  BikeService bikeService = new BikeService();
  void updateBikeIsBooking(bool isBooking, BookingModel bookingModel) {
    mainBooking.bikeModel.isBooking = isBooking;
    Future<bool> futureCase = bikeService.updateBikeModel(
        mainBooking.bikeModel.id,
        mainBooking.bikeModel,
        widget.userModel.token);
    futureCase.then((isUpdateSuccess) {
      if (this.mounted) {
        if (!isUpdateSuccess) {
          showNotificationDialog(
            "Cảnh bảo!",
            "Thao tác thất bại, vui lòng thử lại!",
            my_colors.danger,
          );
        } else {
          updateBookingEventType(bookingModel);
        }
      }
    });
  }

  bool _isCreatePaymentSuccess = false;
  PaymentService paymentService = new PaymentService();
  void createPayment(PaymentModel model) {
    Future<PaymentModel> futureCase =
        paymentService.createPayment(model, widget.userModel.token);
    futureCase.then((model) {
      if (this.mounted) {
        if (model != null) {
          _isCreatePaymentSuccess = true;
        } else {
          showNotificationDialog(
            "Cảnh bảo!",
            "Thao tác thất bại, vui lòng thử lại!",
            my_colors.danger,
          );
        }
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

  LocationService locationService = new LocationService();
  String getIdOfNewLocation(LocationModel locModel) {
    Future<LocationModel> futureCase =
        locationService.createLocation(locModel, widget.userModel.token);
    futureCase.then((model) {
      if (this.mounted) {
        setState(() {
          returnLocation = model;
        });
        return model.id;
      }
    });
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    returnLocation = widget.locationModel;
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
      if (mainBooking.locationReturnBikeModel != null) {
        returnLocation = mainBooking.locationReturnBikeModel;
      } else {
        returnLocation = widget.locationModel;
      }
      double lati = double.parse(returnLocation.latitude);
      double long = double.parse(returnLocation.longitude);
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
                  // if (!_isLoadThisScreen) {
                  return (!snapshot.hasData)
                      ? Column(
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
                        )
                      // } else {
                      // return
                      : Column(
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
                                    backgroundImage:
                                        (mainBooking.bikeModel != null &&
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                              children: mainBooking.bikeModel.listBikeImage
                                  .map((imgs) => ClipRRect(
                                      child: Image.network(imgs.imageUrl,
                                          fit: BoxFit.cover)))
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
                            if (mainBooking.locationReturnBikeModel != null ||
                                widget.locationModel != null)
                              InkWell(
                                onTap: () {
                                  if (mainBooking.eventTypeId == "ARERENTING") {
                                    if (widget.userModel.username ==
                                        mainBooking.userName) {
                                      helper.pushInto(
                                        context,
                                        BikeReturnMap(
                                          userModel: widget.userModel,
                                          locationModel: returnLocation,
                                        ),
                                        true,
                                      );
                                    }
                                  }
                                },
                                child: getLocationWidget(
                                  "Địa điểm " +
                                      ((widget.isCustomer) ? "trả" : "lấy") +
                                      " xe:",
                                  _bikeReturnAddress,
                                  _initialCameraPositionReturn,
                                  _markersReturn,
                                  _onMapCreatedReturn,
                                  (mainBooking.eventTypeId == "ARERENTING")
                                      ? (widget.userModel.username ==
                                              mainBooking.userName)
                                          ? true
                                          : false
                                      : false,
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  // gói thuê
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gói thuê: ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(
                                            mainBooking.payPackageModel.name,
                                            style: TextStyle(fontSize: 15)),
                                      ),
                                    ],
                                  ),
                                  // thời gian thuê
                                  if (mainBooking.eventTypeId == "ARERENTING" ||
                                      mainBooking.eventTypeId == "OWNGOTBIKE" ||
                                      mainBooking.eventTypeId ==
                                          "CUSRETURNBIKE" ||
                                      mainBooking.eventTypeId == "PAYING" ||
                                      mainBooking.eventTypeId == "RATING")
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Ngày giờ thuê: ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Expanded(
                                              child: Text(
                                                  helper.getDateFormatStr(
                                                      mainBooking.dateBegin),
                                                  style:
                                                      TextStyle(fontSize: 15)),
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
                                                        DateTime.now()
                                                            .toString(),
                                                      ),
                                                      style: TextStyle(
                                                          fontSize: 15),
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
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                      (mainBooking.dateEnd !=
                                                              null)
                                                          ? mainBooking.dateEnd
                                                          : DateTime.now()
                                                              .toString(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      mainBooking.eventTypeId ==
                                          "CUSRETURNBIKE" ||
                                      mainBooking.eventTypeId == "PAYING" ||
                                      mainBooking.eventTypeId == "RATING")
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                      (mainBooking.dateEnd !=
                                                              null)
                                                          ? mainBooking.dateEnd
                                                          : DateTime.now()
                                                              .toString(),
                                                      mainBooking.bikeModel
                                                          .bikeTypeModel.id,
                                                      mainBooking
                                                          .payPackageModel,
                                                    ) +
                                                    " VND",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (mainBooking.eventTypeId == "OWNGOTBIKE" &&
                                      widget.userModel.username ==
                                          mainBooking.userName)
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                              border: Border.all(
                                                  color: Colors.grey),
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

                            if (widget.isCustomer)
                              Column(
                                children: [
                                  //Đồng ý - huỷ
                                  if (mainBooking.eventTypeId ==
                                      "OWNSHIPPEDBIKE")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 180,
                                          title: 'Đồng ý thuê xe',
                                          onPressedElavateBtn: () {
                                            BookingModel tmpModel = mainBooking;
                                            tmpModel.dateBegin = DateTime.now()
                                                .toIso8601String();
                                            tmpModel.eventTypeId = "ARERENTING";
                                            setState(() {
                                              updateBikeIsBooking(
                                                  true, tmpModel);
                                            });
                                          },
                                        ),
                                        SizedBox(width: 20),
                                        OutlineBtn(
                                          width: 180,
                                          title: 'Hủy thuê xe',
                                          onPressedOutlineBtn: () {
                                            BookingModel tmpModel = mainBooking;

                                            tmpModel.dateEnd = DateTime.now()
                                                .toIso8601String();
                                            tmpModel.eventTypeId = "CANCELED";
                                            setState(() {
                                              updateBookingEventType(tmpModel);
                                            });
                                            // showConfirmDialog(
                                            //   "Huỷ thuê xe",
                                            //   "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                                            //   RentBikeManager(
                                            //     userModel: widget.userModel,
                                            //     tabIndex: 0,
                                            //   ),
                                            // );
                                            // showConfirmDialog(
                                            //   "Tiếp tục thuê?",
                                            //   "Bạn có muốn tiếp tục thuê không?",
                                            //   Home(userModel: widget.userModel),
                                            // );
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
                                                  locationModel:
                                                      widget.locationModel,
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
                                                  if (widget.locationModel !=
                                                      null) {
                                                    BookingModel tmpModel =
                                                        mainBooking;
                                                    if (widget
                                                            .locationModel.id !=
                                                        null) {
                                                      tmpModel.locationReturnBike =
                                                          widget
                                                              .locationModel.id;
                                                    } else {
                                                      tmpModel.locationReturnBike =
                                                          getIdOfNewLocation(
                                                              widget
                                                                  .locationModel);
                                                    }
                                                    if (tmpModel
                                                            .locationReturnBike !=
                                                        null) {
                                                      tmpModel
                                                          .dateEnd = DateTime
                                                              .now()
                                                          .toIso8601String();
                                                      tmpModel.eventTypeId =
                                                          "CUSRETURNBIKE";
                                                      setState(() {
                                                        updateBookingEventType(
                                                            tmpModel);
                                                      });
                                                    } else {
                                                      showNotificationDialog(
                                                        "Cảnh báo!",
                                                        "Thao tác thất bại!",
                                                        my_colors.danger,
                                                      );
                                                    }
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                  if (mainBooking.eventTypeId == "OWNGOTBIKE")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 380,
                                          title: 'Thanh toán',
                                          onPressedElavateBtn: () {
                                            bool isPaymentTypeChange =
                                                _paymentTypeStr !=
                                                    "Chọn hình thức thanh toán:";
                                            if (isPaymentTypeChange) {
                                              setState(() {
                                                String totalPriceStr =
                                                    helper.getPriceTotalStr(
                                                  mainBooking.dateBegin,
                                                  mainBooking.dateEnd,
                                                  mainBooking.bikeModel
                                                      .bikeTypeModel.id,
                                                  mainBooking.payPackageModel,
                                                );

                                                PaymentModel payModel =
                                                    PaymentModel(
                                                  bookingId: mainBooking.id,
                                                  paymentTypeId:
                                                      _paymentTypeModel.id,
                                                  totalPrice: double.parse(
                                                      totalPriceStr),
                                                );

                                                createPayment(payModel);

                                                if (_isCreatePaymentSuccess) {
                                                  // setState(() {
                                                  BookingModel tmpModel =
                                                      mainBooking;
                                                  tmpModel.eventTypeId =
                                                      "PAYING";
                                                  updateBookingEventType(
                                                      tmpModel);
                                                  if (_isUpdateBookingSuccess) {
                                                    helper.pushInto(
                                                      context,
                                                      Rating(
                                                        userModel:
                                                            widget.userModel,
                                                        bookingModel:
                                                            mainBooking,
                                                      ),
                                                      true,
                                                    );
                                                  }
                                                  // });
                                                }
                                              });
                                            } else {
                                              showNotificationDialog(
                                                "Cảnh báo!",
                                                "Vui lòng chọn hình thức thanh toán!",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 180,
                                          title: 'Đồng ý cho thuê',
                                          onPressedElavateBtn: () {
                                            BookingModel tmpModel = mainBooking;
                                            tmpModel.eventTypeId =
                                                "OWNSHIPPINGBIKE";
                                            setState(() {
                                              updateBookingEventType(tmpModel);
                                            });
                                          },
                                        ),
                                        SizedBox(width: 20),
                                        OutlineBtn(
                                          width: 180,
                                          title: 'Từ chối cho thuê',
                                          onPressedOutlineBtn: () {
                                            BookingModel tmpModel = mainBooking;
                                            tmpModel.dateEnd = DateTime.now()
                                                .toIso8601String();
                                            tmpModel.eventTypeId = "CANCELED";
                                            setState(() {
                                              updateBookingEventType(tmpModel);
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
                                  if (mainBooking.eventTypeId ==
                                      "OWNSHIPPINGBIKE")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 380,
                                          title: 'Đã giao xe',
                                          onPressedElavateBtn: () {
                                            BookingModel tmpModel = mainBooking;
                                            tmpModel.eventTypeId =
                                                "OWNSHIPPEDBIKE";
                                            setState(() {
                                              updateBookingEventType(tmpModel);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  if (mainBooking.eventTypeId ==
                                      "CUSRETURNBIKE")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 380,
                                          title: 'Đã lấy xe',
                                          onPressedElavateBtn: () {
                                            BookingModel tmpModel = mainBooking;
                                            tmpModel.eventTypeId = "OWNGOTBIKE";
                                            setState(() {
                                              updateBookingEventType(tmpModel);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  if (mainBooking.eventTypeId == "PAYING")
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElavateBtn(
                                          width: 380,
                                          title: 'Xác nhận thanh toán',
                                          onPressedElavateBtn: () {
                                            BookingModel tmpModel = mainBooking;
                                            tmpModel.eventTypeId = "FINISHED";
                                            setState(() {
                                              updateBikeIsBooking(
                                                  false, tmpModel);
                                              if (_isUpdateBookingSuccess) {
                                                helper.pushInto(
                                                  context,
                                                  Rating(
                                                    userModel: widget.userModel,
                                                    bookingModel: mainBooking,
                                                  ),
                                                  true,
                                                );
                                              }
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                ],
                              ),

                            // if (mainBooking.eventTypeId == "RATING")
                            //   if ((widget.userModel.username ==
                            //               mainBooking.userName &&
                            //           !mainBooking.isCustomerRated) ||
                            //       (widget.userModel.username !=
                            //               mainBooking.userName &&
                            //           !mainBooking.isOwnerRated))
                            //     Column(
                            //       children: [
                            //         Card(
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(15),
                            //           ),
                            //           margin:
                            //               EdgeInsets.only(left: 10, right: 10),
                            //           elevation: 5,
                            //           child: Padding(
                            //             padding: EdgeInsets.all(15),
                            //             child: Column(
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Text(
                            //                       "Đánh giá:",
                            //                       style: TextStyle(
                            //                         fontSize: 20,
                            //                         fontWeight: FontWeight.bold,
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 SizedBox(height: 20),
                            //                 RatingStars(
                            //                   value: ratingNum,
                            //                   onValueChanged: (val) {
                            //                     setState(() {
                            //                       ratingNum = val;
                            //                     });
                            //                   },
                            //                   starBuilder: (index, color) =>
                            //                       Icon(
                            //                     Icons.star,
                            //                     color: color,
                            //                     size: 50,
                            //                   ),
                            //                   starSize: 50,
                            //                   starCount: 5,
                            //                   maxValue: 5,
                            //                   starSpacing: 5,
                            //                   valueLabelVisibility: false,
                            //                   starOffColor: Colors.grey,
                            //                   starColor: Colors.yellow,
                            //                 ),
                            //                 SizedBox(height: 20),
                            //                 TextField(
                            //                   controller: ratingContent,
                            //                   minLines: 1,
                            //                   keyboardType:
                            //                       TextInputType.multiline,
                            //                   maxLines: null,
                            //                   decoration: InputDecoration(
                            //                       labelText:
                            //                           "Nội dung đánh giá"),
                            //                   style: TextStyle(fontSize: 15),
                            //                   onChanged: (val) {},
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         SizedBox(height: 20),
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           children: [
                            //             ElavateBtn(
                            //               width: 180,
                            //               title: 'Gửi đánh giá',
                            //               onPressedElavateBtn: () {
                            //                 setState(() {
                            //                   BookingModel tmpModel =
                            //                       mainBooking;
                            //                   if (widget.userModel.username ==
                            //                       mainBooking.userName) {
                            //                     mainBooking.customerRating =
                            //                         ratingNum.toInt();
                            //                     mainBooking.customerReport =
                            //                         ratingContent.text;
                            //                     mainBooking.isCustomerRated =
                            //                         true;
                            //                   } else {
                            //                     mainBooking.ownerRating =
                            //                         ratingNum.toInt();
                            //                     mainBooking.ownerReport =
                            //                         ratingContent.text;
                            //                     mainBooking.isOwnerRated = true;
                            //                   }
                            //                   if (mainBooking.isCustomerRated &&
                            //                       mainBooking.isOwnerRated) {
                            //                     tmpModel.eventTypeId =
                            //                         "FINISHED";
                            //                   }
                            //                   setState(() {
                            //                     updateBookingEventType(
                            //                         tmpModel);
                            //                   });
                            //                 });
                            //               },
                            //             ),
                            //             SizedBox(width: 20),
                            //             OutlineBtn(
                            //               width: 180,
                            //               title: 'Bỏ qua',
                            //               onPressedOutlineBtn: () {
                            //                 BookingModel tmpModel = mainBooking;
                            //                 tmpModel.eventTypeId = "FINISHED";
                            //                 setState(() {
                            //                   updateBookingEventType(tmpModel);
                            //                 });
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),

                            SizedBox(height: 15),
                            //===========================================
                          ],
                        );
                }
                // },
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
