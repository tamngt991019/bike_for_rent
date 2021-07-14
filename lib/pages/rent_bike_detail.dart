import 'dart:async';
import 'dart:io';
import 'Dart:math' as math;
import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/pages/rent_bike_list.dart';
import 'package:bike_for_rent/pages/tracking_booking.dart';
import 'package:bike_for_rent/services/bike_service.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/services/location_service.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:bike_for_rent/widgets/notification_dialog.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bike_for_rent/constants/event_type_id.dart' as eventTypeId;

class RentBikeDetail extends StatefulWidget {
  final UserModel userModel;
  final BikeModel bikeModel;
  final BikeTypeModel bikeTypeModel;
  final LocationModel locationModel;
  final PayPackageModel payPackageModel;
  const RentBikeDetail({
    Key key,
    this.userModel,
    this.bikeModel,
    this.bikeTypeModel,
    this.locationModel,
    this.payPackageModel,
  }) : super(key: key);

  @override
  _RentBikeDetailState createState() => _RentBikeDetailState();
}

class _RentBikeDetailState extends State<RentBikeDetail> {
  bool _isLoadBikeInfo = false;
  bool _isLoadLocationInfo = false;
  bool _isLoadRatingInfo = false;
  bool _isLoadOnwerRatingInfo = false;

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

  String _bikeGetAddress = "";
  // Location lati, long ---------------------------------
  // double locLati = 10.841493;s
  // double locLong = 106.810038;
  // Map ---------------------------------
  // LatLng _latLng; //= LatLng(locLati, locLong);

  // UserService userService = new UserService();
  // UserModel _ownerModel;
  // Future getOwnerById(String id) {
  //   if (_ownerModel == null) {
  //     _ownerModel = new UserModel();
  //   }

  //   Future<UserModel> futureCases = userService.getUserById(id);
  //   futureCases.then((model) {
  //     if (this.mounted) {
  //       setState(() {
  //         _ownerModel = model;
  //         _isLoadOwnerInfo = true;
  //       });
  //     }
  //   });
  //   return futureCases;
  // }

  BookingService bookingService = new BookingService();
  List<BookingModel> bookingByBikeIdWithRatingList;
  Future loadListBookingByBikeIdWithRating(String bikeId) {
    if (bookingByBikeIdWithRatingList == null) {
      bookingByBikeIdWithRatingList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.getListBookingByBikeIdWithRating(bikeId);
    futureCases.then((list) {
      if (this.mounted) {
        setState(() {
          this.bookingByBikeIdWithRatingList = list;
          _isLoadRatingInfo = true;
        });
      }
    });
    return futureCases;
  }

  BikeService bikeService = new BikeService();
  BikeModel _bikeModel;
  Future getBikeByIdWithTypeBrandImagesUser(String id) {
    if (_bikeModel == null) {
      _bikeModel = new BikeModel();
    }
    Future<BikeModel> futureCases =
        bikeService.getBikeByIdWithTypeBrandImagesUser(id);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          _bikeModel = model;
          _isLoadBikeInfo = true;
        });
      }
    });
    return futureCases;
  }

  double getRatingAverage(List<BookingModel> list) {
    double result = 0;
    for (var item in list) {
      result += item.customerRating;
    }
    result = double.parse((result / list.length).toStringAsFixed(1));
    return result;
  }

  Widget getNumberOfStart(double number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < number; i++)
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20,
          ),
      ],
    );
  }

  List<BookingModel> ownerWithRatingList;
  Future loadListOwnerWithRating(String username) {
    if (ownerWithRatingList == null) {
      ownerWithRatingList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.getListOwnerBookingWithRating(username);
    futureCases.then((list) {
      if (this.mounted) {
        setState(() {
          this.ownerWithRatingList = list;
          _isLoadOnwerRatingInfo = true;
        });
      }
    });
    return futureCases;
  }

  @override
  void initState() {
    super.initState();
  }

  LocationService locService = new LocationService();
  LatLng _latLing;
  Future getLocationById(String id) {
    Future<LocationModel> futureCases = locService.getLocationById(id);
    futureCases.then((model) {
      _latLing =
          LatLng(double.parse(model.latitude), double.parse(model.longitude));
      _isLoadLocationInfo = true;
    });
    return futureCases;
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
      getLocation(_latLing);
      // getLocation(LatLng(10.82414068863801, 106.63065063707423));
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
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
            context,
            RentBikeList(
              userModel: widget.userModel,
              bikeTypeModel: widget.bikeTypeModel,
              payPackageModel: widget.payPackageModel,
              locationModel: widget.locationModel,
            ),
            false,
          ),
        ),
        // Body app
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Thông tin xe
                FutureBuilder(
                  future:
                      getBikeByIdWithTypeBrandImagesUser(widget.bikeModel.id),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        // danh sách ảnh của xe
                        if (_isLoadBikeInfo &&
                            _isLoadLocationInfo &&
                            _isLoadRatingInfo)
                          ImageSlideshow(
                            width: double.infinity,
                            height: 250,
                            initialPage: 0,
                            indicatorColor: my_colors.primary,
                            indicatorBackgroundColor: Colors.white,
                            children: imageUrls()
                                .map((img) => ClipRRect(
                                    child:
                                        Image.network(img, fit: BoxFit.cover)))
                                .toList(),
                            onPageChanged: (value) {},
                            autoPlayInterval: 60000,
                          ),
                        if (_isLoadBikeInfo &&
                            _isLoadLocationInfo &&
                            _isLoadRatingInfo)
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Bookingdetail(
                              bikeModel: _bikeModel,
                              isCustomerHistory: false,
                              isCustomerHistoryDetail: false,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                // thông tin yêu cầu thuê
                SizedBox(height: 10),
                FutureBuilder(
                  future: getLocationById(widget.locationModel.id),
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          if (_isLoadBikeInfo &&
                              _isLoadLocationInfo &&
                              _isLoadRatingInfo)
                            Row(
                              children: [
                                FrameText(
                                  title: "Địa điểm giao / nhận xe",
                                  content: _bikeGetAddress,
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
                // ban do hien thi vi tri lay xe
                if (_isLoadBikeInfo && _isLoadLocationInfo && _isLoadRatingInfo)
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
                // THÔNG TIN CHỦ XE
                if (_isLoadBikeInfo && _isLoadLocationInfo && _isLoadRatingInfo)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // avatar
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                (_bikeModel.userModel.avatar != null &&
                                        _bikeModel.userModel.avatar.isEmpty ==
                                            false)
                                    ? NetworkImage(_bikeModel.userModel.avatar)
                                    : AssetImage(
                                        "lib/assets/images/avatar_logo.png",
                                      ),
                          ),
                          SizedBox(width: 10),
                          // tên người dùng và sđt
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // tên người dùng
                                Text(
                                  _bikeModel.userModel.fullName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_bikeModel.userModel.phone != null)
                                  SizedBox(height: 5),
                                if (_bikeModel.userModel.phone != null)
                                  Text(
                                    _bikeModel.userModel.phone,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Chủ xe",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              FutureBuilder(
                                future: loadListOwnerWithRating(
                                    _bikeModel.username),
                                builder: (context, snapshot) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (_isLoadOnwerRatingInfo)
                                        RatingBarIndicator(
                                          rating: getRatingAverage(
                                              ownerWithRatingList),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          itemCount: 5,
                                          itemSize: 25,
                                          direction: Axis.horizontal,
                                        ),
                                      // for (var i = 0;
                                      //     i <
                                      //         getRatingAverage(
                                      //             ownerWithRatingList);
                                      //     i++)
                                      //   Icon(
                                      //     Icons.star,
                                      //     color: Colors.yellow,
                                      //     size: 20,
                                      //   ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_isLoadBikeInfo && _isLoadLocationInfo && _isLoadRatingInfo)
                  SizedBox(height: 15),

                if (_isLoadBikeInfo && _isLoadLocationInfo && _isLoadRatingInfo)
                  ElavateBtn(
                      width: MediaQuery.of(context).size.width * 80 / 100,
                      title: "Thuê ngay",
                      onPressedElavateBtn: () {
                        BookingModel newBooking = BookingModel(
                          userName: widget.userModel.username,
                          bikeId: _bikeModel.id,
                          locationGetBike: widget.locationModel.id,
                          payPackageId: widget.payPackageModel.id,
                          eventTypeId: "PROCESSING",
                        );
                        // print(newBooking.userName);
                        // print(newBooking.bikeId);
                        // print(newBooking.locationGetBike);
                        // print(newBooking.payPackageId);
                        // print(newBooking.eventTypeId);
                        Future<BookingModel> bookingDuture =
                            bookingService.createBooking(newBooking);
                        bookingDuture.then((value) {
                          if (value != null) {
                            print("Thuê thành công!");
                            // NotificationDialog(
                            //   title: "Thông báo!",
                            //   titleColor: my_colors.danger,
                            //   content: "Thuê thành công!",
                            // );
                            // helper.pushInto(context,
                            //     TrackingBooking(isCustomer: true), true);
                          } else {
                            NotificationDialog(
                              title: "Cảnh báo!",
                              titleColor: my_colors.danger,
                              content: "Thuê thất bại, vui lòng thử lại!",
                            );
                          }
                        });
                      }),
                // đánh giá
                if (_isLoadBikeInfo && _isLoadLocationInfo && _isLoadRatingInfo)
                  SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FutureBuilder(
                    future:
                        loadListBookingByBikeIdWithRating(widget.bikeModel.id),
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_isLoadBikeInfo &&
                              _isLoadLocationInfo &&
                              _isLoadRatingInfo)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Đánh giá",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    if (bookingByBikeIdWithRatingList != null)
                                      Row(
                                        children: [
                                          Text(
                                            (getRatingAverage(
                                                    bookingByBikeIdWithRatingList))
                                                .toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 20,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            " ∙ ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    Text(
                                      ((bookingByBikeIdWithRatingList != null)
                                                  ? bookingByBikeIdWithRatingList
                                                      .length
                                                  : 0)
                                              .toString() +
                                          " nhận xét",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                  height: 10,
                                ),
                              ],
                            ),
                          if (_isLoadBikeInfo &&
                              _isLoadLocationInfo &&
                              _isLoadRatingInfo)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: bookingByBikeIdWithRatingList == null
                                  ? 0
                                  : bookingByBikeIdWithRatingList.length,
                              itemBuilder: (BuildContext context, int index) {
                                UserModel _user =
                                    bookingByBikeIdWithRatingList[index]
                                        .userModel;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // avatar
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: (_user.avatar !=
                                                      null &&
                                                  _user.avatar.isEmpty == false)
                                              ? NetworkImage(_user.avatar)
                                              : AssetImage(
                                                  "lib/assets/images/avatar_logo.png",
                                                ),
                                        ),
                                        SizedBox(width: 10),
                                        // tên người dùng và sđt
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // tên người dùng
                                              Text(
                                                _user.fullName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              getNumberOfStart(
                                                double.parse(
                                                  bookingByBikeIdWithRatingList[
                                                          index]
                                                      .customerRating
                                                      .toString(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Nội dung đánh giá của bạn
                                    Row(
                                      children: [
                                        FrameText(
                                          title: "",
                                          content:
                                              bookingByBikeIdWithRatingList[
                                                      index]
                                                  .customerReport,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                ),

                if (!(_isLoadBikeInfo &&
                    _isLoadLocationInfo &&
                    _isLoadRatingInfo))
                  Text(
                    "Đang tải dữ liệu . . .",
                    style: TextStyle(fontSize: 20, color: my_colors.primary),
                  ),
              ],
            ),
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
}
