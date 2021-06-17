import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class BookingCard extends StatelessWidget {
  final Object user;
  final Object booking;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  BookingCard(
      {Key key,
      this.user,
      this.booking,
      this.isCustomerHistory,
      this.isCustomerHistoryDetail})
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Loại xe: " + "Xe số / tay ga",
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 10),
                          Text("Háng: " + "HONDA / YAMAHA",
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
                if (isCustomerHistory && isCustomerHistoryDetail)
                  SizedBox(height: 20),
                if (isCustomerHistory && isCustomerHistoryDetail)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "Ngày / giờ thuê xe: " + "30/12/2021 - 15:30",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                if (isCustomerHistory && isCustomerHistoryDetail)
                  SizedBox(height: 10),
                if (isCustomerHistory && isCustomerHistoryDetail)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "Ngày / giờ trả xe: " + "31/12/2021 - 15:30",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isCustomerHistory) SizedBox(height: 15),
                          if (isCustomerHistory)
                            Text("Thời gian thuê: " + "1 ngày 10 tiếng",
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
                          if (isCustomerHistory) SizedBox(height: 15),
                          if (isCustomerHistory)
                            Text("Tổng tiền: " + "123456 vnd",
                                style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
                // if (isCustomerHistory) SizedBox(height: 15),
                // if (isCustomerHistory)
                //   Text("Thời gian thuê: " + "1 ngày 10 tiếng",
                //       style: TextStyle(fontSize: 15)),
                // if (isCustomerHistory) SizedBox(height: 15),
                // if (isCustomerHistory)
                //   Text("Tổng tiền: " + "123456 vnd",
                //       style: TextStyle(fontSize: 15)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
