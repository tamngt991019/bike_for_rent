import 'dart:async';

import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/pages/rent_bike_list.dart';
import 'package:bike_for_rent/pages/tracking_booking.dart';
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
  final BikeTypeModel bikeTypeModel;
  final LocationModel locationModel;
  final PayPackageModel payPackageModel;
  const RentBikeDetail({
    Key key,
    this.userModel,
    this.bikeTypeModel,
    this.locationModel,
    this.payPackageModel,
  }) : super(key: key);

  @override
  _RentBikeDetailState createState() => _RentBikeDetailState();
}

class _RentBikeDetailState extends State<RentBikeDetail> {
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
          // onPressedBackBtn: () => runApp(MaterialApp(home: RentBikeList())),
          onPressedBackBtn: () => helper.pushInto(
              context, RentBikeFilter(userModel: widget.userModel), false),
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
                onPageChanged: (value) {
                  print('Page changed: $value');
                },
                autoPlayInterval: 60000,
              ),
              // thông tin yêu cầu thuê
              Padding(
                padding: const EdgeInsets.all(10),
                child: Bookingdetail(
                  isCustomerHistory: false,
                  isCustomerHistoryDetail: false,
                ),
              ),
              SizedBox(height: 10),
              // vị trí nhận xe
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    FrameText(
                      title: "Địa điểm giao / nhận xe",
                      content: _bikeGetAddress,
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
                    target: LatLng(10.867108878090859, 106.8030191050504),
                    zoom: 13,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId("ID-1"),
                      position: LatLng(10.867108878090859, 106.8030191050504),
                    )
                  },
                  onMapCreated: onMapCreated,
                ),
              ),
              // THÔNG TIN CHỦ XE
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin:
                    EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // tên người dùng
                            Text(
                              "Tên chủ xe",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "0987654321",
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
                          // tên người dùng
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
              ElavateBtn(
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  title: "Thuê ngay",
                  onPressedElavateBtn: () => helper.pushInto(
                      context, TrackingBooking(isCustomer: true), true)
                  // runApp(
                  //     MaterialApp(home: TrackingBooking(isCustomer: true))),
                  ),
              SizedBox(height: 5),
              // đánh giá
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
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
                            Text(
                              "5",
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
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "10" + " nhận xét",
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
                    Column(
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
                              backgroundImage: NetworkImage(
                                  "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
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
                                    "Tên người thuê xe",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              content: "1 vài nội dung đánh giá ở đây",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
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
                              backgroundImage: NetworkImage(
                                  "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
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
                                    "Tên người thuê xe",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  "1 vài nội dung đánh giá ở đây 1 vài nội dung đánh giá ở đây 1 vài nội dung đánh giá ở đây 1 vài nội dung đánh giá ở đây 1 vài nội dung đánh giá ở đây 1 vài nội dung đánh giá ở đây",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
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
}
