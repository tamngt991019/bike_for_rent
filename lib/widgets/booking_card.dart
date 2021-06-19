import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class BookingCard extends StatelessWidget {
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  BookingCard({Key key, this.isCustomerHistory, this.isCustomerHistoryDetail})
      : super(key: key);

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          // Hình ảnh xe
          ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: my_colors.primary,
            indicatorBackgroundColor: Colors.white,
            children: imageUrls()
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
          // Thông tin chi tiết xe
          Padding(
            padding: const EdgeInsets.all(15),
            child: Bookingdetail(
              isCustomerHistory: isCustomerHistory,
              isCustomerHistoryDetail: isCustomerHistoryDetail,
            ),
          ),
        ],
      ),
    );
  }
}
