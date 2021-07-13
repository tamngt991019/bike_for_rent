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
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;

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
  double _ratingNum = 0;

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
  double locLati = 10.841493;
  double locLong = 106.810038;
  // Map ---------------------------------
  // LatLng _latLng; //= LatLng(locLati, locLong);

  UserService userService = new UserService();
  UserModel _ownerModel;
  UserModel _customerModel;
  Future getOwnerById(String id) {
    if (_ownerModel == null) {
      _ownerModel = new UserModel();
    }

    Future<UserModel> futureCases = userService.getUserById(id);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          _ownerModel = model;
        });
      }
    });
    return futureCases;
  }

  BookingService bookingService = new BookingService();
  List<BookingModel> bookingList;
  double avgRating = -1;
  Future loadListBookingByBikeIdWithRating(String bikeId) {
    if (bookingList == null) {
      bookingList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.getListBookingByBikeIdWithRating(bikeId);
    futureCases.then((_bookingList) {
      if (this.mounted) {
        setState(() {
          this.bookingList = _bookingList;
        });
      }
    });
    return futureCases;
  }

  Future getCustomerById(String id) {
    if (_customerModel == null) {
      _customerModel = new UserModel();
    }

    Future<UserModel> futureCases = userService.getUserById(id);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          _customerModel = model;
        });
      }
    });
    return futureCases;
  }

  double getAverage(List<BookingModel> list) {
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
            size: 22,
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  LocationService locService = new LocationService();
  Future getLocationById(String id) {
    return locService.getLocationById(id);
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

  void _onMapCreated(GoogleMapController _controller) {
    _ggMapController.complete(_controller);
    setState(() {
      LatLng _inLatLing;
      Future<LocationModel> future =
          locService.getLocationById(widget.locationModel.id);
      future.then((model) {
        // lay toa do
        _inLatLing =
            LatLng(double.parse(model.latitude), double.parse(model.longitude));
        // lay dia chi
        getAddress(_inLatLing.latitude, _inLatLing.longitude).then((add1) {
          this._bikeGetAddress = add1;
        });
        // danh dau
        _markers.add(
          Marker(
            markerId: MarkerId("ID-1"),
            position: _inLatLing,
          ),
        );
        // setup camera
        _initialCameraPosition =
            CameraPosition(target: _inLatLing, zoom: cameraZoom);
        moveCamera();
      });
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // danh sách ảnh của xe
              ImageSlideshow(
                width: double.infinity,
                height: 250,
                initialPage: 0,
                indicatorColor: my_colors.primary,
                indicatorBackgroundColor: Colors.white,
                children: imageUrls()
                    .map((img) =>
                        ClipRRect(child: Image.network(img, fit: BoxFit.cover)))
                    .toList(),
                onPageChanged: (value) {},
                autoPlayInterval: 60000,
              ),
              // thông tin yêu cầu thuê
              Padding(
                padding: EdgeInsets.all(10),
                child: Bookingdetail(
                  bikeModel: widget.bikeModel,
                  isCustomerHistory: false,
                  isCustomerHistoryDetail: false,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    FutureBuilder(
                      future: getLocationById(widget.locationModel.id),
                      builder: (context, snapshot) {
                        return FrameText(
                          title: "Địa điểm giao / nhận xe",
                          content: _bikeGetAddress,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // ban do hien thi vi tri lay xe
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
                      Expanded(
                        child: FutureBuilder(
                          future: getOwnerById(widget.bikeModel.userName),
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: (_ownerModel.avatar !=
                                              null &&
                                          _ownerModel.avatar.isEmpty == false)
                                      ? NetworkImage(_ownerModel.avatar)
                                      : AssetImage(
                                          "lib/assets/images/avatar_logo.png",
                                        ),
                                ),
                                SizedBox(width: 10),
                                // tên người dùng và sđt
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // tên người dùng
                                      if (_ownerModel.fullName != null)
                                        Text(
                                          _ownerModel.fullName,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      if (_ownerModel.phone != null)
                                        SizedBox(height: 5),
                                      if (_ownerModel.phone != null)
                                        Text(
                                          _ownerModel.phone,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0; i < 5; i++)
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
              ElavateBtn(
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  title: "Thuê ngay",
                  onPressedElavateBtn: () => helper.pushInto(
                      context, TrackingBooking(isCustomer: true), true)),
              SizedBox(height: 5),
              // đánh giá
              // if (1 == 2)
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đánh giá",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                if (bookingList != null)
                                  Row(
                                    children: [
                                      Text(
                                        (getAverage(bookingList)).toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 18,
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
                                  ((bookingList != null)
                                              ? bookingList.length
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              bookingList == null ? 0 : bookingList.length,
                          itemBuilder: (BuildContext context, int index) {
                            UserModel _user = bookingList[index].userModel;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // avatar
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: (_user.avatar != null &&
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
                                          SizedBox(height: 5),
                                          getNumberOfStart(
                                            double.parse(
                                              bookingList[index]
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
                                          bookingList[index].customerReport,
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
}
