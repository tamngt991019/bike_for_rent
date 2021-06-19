import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HistoryDetail extends StatelessWidget {
  const HistoryDetail({Key key}) : super(key: key);
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
              // vị trí
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
