import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'test.dart';

class TrackingBooking extends StatefulWidget {
  const TrackingBooking({Key? key}) : super(key: key);

  @override
  _TrackingBookingState createState() => _TrackingBookingState();
}

class _TrackingBookingState extends State<TrackingBooking> {
  final PageController pController = PageController(initialPage: 0);
  List<String> image_urls = [
    "https://media.publit.io/file/BikeForRent/banner/banner1.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner2.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner3.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner4.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner5.jpg",
  ];

  @override
  // ignore: must_call_super
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: Appbar(
          titles: "Titles text",
          isShowBackBtn: true,
          onPressedBackBtn: () => runApp(Test()),
        ),
        // Body app
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Ten người dùng, sđt, avatar
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                borderOnForeground: true,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // avatar
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                      ),
                      SizedBox(width: 20),
                      // tên người dùng và sđt
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // tên người dùng
                            Text(
                              "Tên người thuê / cho thuê",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            // sđt
                            Text(
                              "Số điện thoại: " + "0987654321",
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
              ),
              SizedBox(height: 10),
              // Thông tin xe máy
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Column(
                  children: [
                    // Hình ảnh xe
                    ImageSlideshow(
                      width: double.infinity,
                      height: 250,
                      initialPage: 0,
                      indicatorColor: my_colors.primary,
                      indicatorBackgroundColor: Colors.white,
                      children: image_urls
                          .map((img) => ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.network(img, fit: BoxFit.cover)))
                          .toList(),
                      onPageChanged: (value) {
                        print('Page changed: $value');
                      },
                      autoPlayInterval: 60000,
                    ),
                    // SizedBox(height: 10),
                    // Thông tin chi tiết xe
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tên xe (SIRIUS)",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                Text("Loại xe: " + "Xe số / tay ga",
                                    style: TextStyle(fontSize: 15)),
                                SizedBox(height: 10),
                                Text("Háng: " + "YAMAHA / HONDA",
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Biển số xe: " + "59X2-12345",
                                    style: TextStyle(fontSize: 15)),
                                SizedBox(height: 10),
                                Text("Màu sắc: " + "Đỏ đen",
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //===========================================
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
