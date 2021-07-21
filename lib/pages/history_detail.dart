import 'dart:async';
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/rent_bike_manager.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryDetail extends StatefulWidget {
  final UserModel userModel;
  final BookingModel bookingModel;
  final bool isCustomer;
  const HistoryDetail({
    Key key,
    this.userModel,
    this.bookingModel,
    this.isCustomer,
  }) : super(key: key);

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  BookingService bookingService = new BookingService();
  BookingModel bookingModelReload;
  bool _isHistoryDetailEmpty = true;
  UserModel _userModel;

  Future getBookingById(String id) {
    if (bookingModelReload == null) {
      bookingModelReload = null;
    }
    Future<BookingModel> futureCases =
        bookingService.getBookingById(id, widget.userModel.token);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          this.bookingModelReload = model;
          if (bookingModelReload != null) {
            if (widget.isCustomer) {
              _userModel = bookingModelReload.userModel;
            } else {
              _userModel = bookingModelReload.bikeModel.userModel;
            }
            _isHistoryDetailEmpty = false;
          }
        });
      }
    });
    return futureCases;
  }

  String _bikeGetAddress = "";
  String _bikeReturnAddress = "";

  Future<String> getAddress(double _inLatitude, double _inLongitude) async {
    final coordinates = new Coordinates(_inLatitude, _inLongitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    return first.addressLine;
  }

  void onMapCreated(GoogleMapController controller) {
    getAddress(10.867108878090859, 106.8030191050504).then((add1) {
      setState(() {
        this._bikeGetAddress = add1;
      });
    });
    getAddress(10.841493, 106.810038).then((add2) {
      setState(() {
        this._bikeReturnAddress = add2;
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
          titles: "Chi tiết lịch sử thuê",
          isShowBackBtn: true,
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
              context,
              (widget.isCustomer)
                  ? History(
                      userModel: widget.userModel,
                      isCustomerHistory: true,
                      isCustomerHistoryDetail: false,
                    )
                  : RentBikeManager(userModel: widget.userModel, tabIndex: 3),
              false),
        ),
        // Body app
        body: FutureBuilder(
          future: getBookingById(widget.bookingModel.id),
          builder: (context, snapshot) {
            // if (_isHistoryDetailEmpty) {
            return (!snapshot.hasData)
                ? getEmptyScreen("Đang tải ...")
                // }
                // return
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ImageSlideshow(
                          width: double.infinity,
                          height: 250,
                          initialPage: 0,
                          indicatorColor: my_colors.primary,
                          indicatorBackgroundColor: Colors.white,
                          children: bookingModelReload.bikeModel.listBikeImage
                              .map((imgs) => ClipRRect(
                                  child: Image.network(imgs.imageUrl,
                                      fit: BoxFit.cover)))
                              .toList(),
                          onPageChanged: (value) {},
                          autoPlayInterval: 60000,
                        ),
                        // thông tin yêu cầu thuê
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Bookingdetail(
                            bookingModel: bookingModelReload,
                            bikeModel: bookingModelReload.bikeModel,
                            isCustomerHistory: true,
                            isCustomerHistoryDetail: true,
                          ),
                        ),

                        // SizedBox(height: 20),
                        //  Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         // avatar
                        //         CircleAvatar(
                        //           radius: 20,
                        //           backgroundImage:
                        //               (_bikeModel.userModel.avatar != null &&
                        //                       _bikeModel.userModel.avatar.isEmpty ==
                        //                           false)
                        //                   ? NetworkImage(_bikeModel.userModel.avatar)
                        //                   : AssetImage(
                        //                       "lib/assets/images/avatar_logo.png",
                        //                     ),
                        //         ),
                        //         SizedBox(width: 10),
                        //         // tên người dùng và sđt
                        //         Expanded(
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               // tên người dùng
                        //               Text(
                        //                 _bikeModel.userModel.fullName,
                        //                 style: TextStyle(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold,
                        //                 ),
                        //               ),
                        //               if (_bikeModel.userModel.phone != null)
                        //                 SizedBox(height: 5),
                        //               if (_bikeModel.userModel.phone != null)
                        //                 Text(
                        //                   _bikeModel.userModel.phone,
                        //                   style: TextStyle(
                        //                     fontSize: 15,
                        //                   ),
                        //                 ),
                        //             ],
                        //           ),
                        //         ),
                        //         SizedBox(width: 10),
                        //         Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.end,
                        //           children: [
                        //             Text(
                        //               "Chủ xe",
                        //               style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //             FutureBuilder(
                        //               future: loadListOwnerWithRating(
                        //                   _bikeModel.username),
                        //               builder: (context, snapshot) {
                        //                 return Row(
                        //                   mainAxisAlignment: MainAxisAlignment.end,
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     if (_isLoadOnwerRatingInfo)
                        //                       RatingBarIndicator(
                        //                         rating: (ownerWithRatingList ==
                        //                                     null ||
                        //                                 ownerWithRatingList.length ==
                        //                                     0)
                        //                             ? 0
                        //                             : getRatingAverage(
                        //                                 ownerWithRatingList),
                        //                         itemBuilder: (context, index) => Icon(
                        //                           Icons.star,
                        //                           color: Colors.yellow,
                        //                         ),
                        //                         itemCount: 5,
                        //                         itemSize: 25,
                        //                         direction: Axis.horizontal,
                        //                       ),
                        //                     // for (var i = 0;
                        //                     //     i <
                        //                     //         getRatingAverage(
                        //                     //             ownerWithRatingList);
                        //                     //     i++)
                        //                     //   Icon(
                        //                     //     Icons.star,
                        //                     //     color: Colors.yellow,
                        //                     //     size: 20,
                        //                     //   ),
                        //                   ],
                        //                 );
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),

                        SizedBox(height: 20),
                        // vị trí nhận xe
                        Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Row(
                            children: [
                              FrameText(
                                title: "Địa điểm nhận xe",
                                content: bookingModelReload
                                    .locationGetBikeModel.address,
                              ),
                            ],
                          ),
                        ),
                        // map vị trí nhận xe
                        Container(
                          height: 250,
                          child: GoogleMap(
                            rotateGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            zoomGesturesEnabled: false,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  double.parse(bookingModelReload
                                      .locationGetBikeModel.latitude),
                                  double.parse(bookingModelReload
                                      .locationGetBikeModel.longitude)),
                              zoom: 13,
                            ),
                            markers: <Marker>{
                              Marker(
                                markerId: MarkerId("ID-1"),
                                position: LatLng(
                                    double.parse(bookingModelReload
                                        .locationGetBikeModel.latitude),
                                    double.parse(bookingModelReload
                                        .locationGetBikeModel.longitude)),
                              )
                            },
                            onMapCreated: onMapCreated,
                          ),
                        ),
                        SizedBox(height: 20),
                        // vị trí trả xe
                        if (bookingModelReload.eventTypeId != "CANCELED")
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    FrameText(
                                      title: "Địa điểm trả xe",
                                      content: bookingModelReload
                                          .locationReturnBikeModel.address,
                                      //"địa chỉ bị null",
                                    ),
                                    //map vị trí trả xe
                                  ],
                                ),
                              ),
                              Container(
                                height: 250,
                                child: GoogleMap(
                                  rotateGesturesEnabled: false,
                                  scrollGesturesEnabled: false,
                                  tiltGesturesEnabled: false,
                                  zoomGesturesEnabled: false,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        double.parse(bookingModelReload
                                            .locationReturnBikeModel.latitude),
                                        double.parse(bookingModelReload
                                            .locationReturnBikeModel
                                            .longitude)),
                                    zoom: 13,
                                  ),
                                  markers: <Marker>{
                                    Marker(
                                      markerId: MarkerId("ID-1"),
                                      position: LatLng(
                                          double.parse(bookingModelReload
                                              .locationReturnBikeModel
                                              .latitude),
                                          double.parse(bookingModelReload
                                              .locationReturnBikeModel
                                              .longitude)),
                                    )
                                  },
                                  onMapCreated: onMapCreated,
                                ),
                              ),
                              SizedBox(height: 20),
                              // đánh giá của bạn
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.isCustomer
                                          ? "Đánh giá của bạn: "
                                          : "Đánh giá của khách hàng",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                                          backgroundImage: NetworkImage(
                                              "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
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
                                                bookingModelReload
                                                    .userModel.fullName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (var i = 0; i < 5; i++)
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 25,
                                                    ),
                                                ],
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
                                              bookingModelReload.customerReport,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10, left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.isCustomer
                                          ? "Đánh giá của chủ xe: "
                                          : "Đánh giá của bạn",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                                          backgroundImage: NetworkImage(
                                              "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
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
                                                bookingModelReload.bikeModel
                                                    .userModel.fullName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (var i = 0; i < 5; i++)
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 22,
                                                    ),
                                                ],
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
                                              bookingModelReload.ownerReport,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    //   ],
                    // ),
                  );
          },
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: (widget.isCustomer) ? 2 : 3,
          userModel: widget.userModel,
          // ? widget.userModel
          // : widget.bookingModel.bikeModel.userModel,
        ),
      ),
    );
  }

  Widget getEmptyScreen(String content) {
    return Center(
      child: Text(
        content,
        style: TextStyle(
          fontSize: 20,
          color: my_colors.primary,
        ),
      ),
    );
  }
}
