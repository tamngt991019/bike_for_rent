import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class CardBike extends StatefulWidget {
  // final Bike bike;
  const CardBike({Key? key}) : super(key: key);

  @override
  _CardBikeState createState() => _CardBikeState();
}

class _CardBikeState extends State<CardBike> {
  List<String> image_urls = [
    "https://media.publit.io/file/BikeForRent/banner/banner1.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner2.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner3.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner4.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner5.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
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
            child: Column(
              children: [
                // Tên xe
                Row(
                  children: [
                    Text("Tên xe: " + "SIRIUS",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
