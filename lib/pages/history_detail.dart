import 'dart:async';

import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({Key key}) : super(key: key);

  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
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
            onPressedBackBtn: () {}),
        // Body app
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                  isCustomerHistory: true,
                  isCustomerHistoryDetail: true,
                ),
              ),
              SizedBox(height: 20),
              // vị trí nhận xe
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    FrameText(
                      title: "Địa điểm nhận xe",
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
              SizedBox(height: 20),
              // vị trí trả xe
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    FrameText(
                      title: "Địa điểm trả xe",
                      content: _bikeReturnAddress,
                    ),
                  ],
                ),
              ),
              //map vị trí trả xe
              Container(
                height: 250,
                child: GoogleMap(
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(10.841493, 106.810038),
                    zoom: 13,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId("ID-1"),
                      position: LatLng(10.841493, 106.810038),
                    )
                  },
                  onMapCreated: onMapCreated,
                ),
              ),
              SizedBox(height: 20),
              // đánh giá của bạn
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đánh giá của bạn: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                                "Tên của bạn (Bạn)",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                          content: "1 vài đánh giá ở đây",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Đánh giá của chủ xe: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                                "Tên chủ xe (Chủ xe)",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ],
          ),
        ),
        // Bottom bar app
        // bottomNavigationBar: BottomBar(
        //   bottomBarIndex: 1,
        // ),
      ),
    );
  }
}
