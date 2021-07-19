import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class BookingCard extends StatefulWidget {
  final BikeModel bikeModel;
  final BookingModel bookingModel;
  final List<String> listImage;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  BookingCard(
      {Key key,
      this.bikeModel,
      this.bookingModel,
      this.listImage,
      this.isCustomerHistory,
      this.isCustomerHistoryDetail})
      : super(key: key);

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
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
    if (widget.bikeModel == null) {
      return Center(
        child: Text("Không có xe nào phù hợp"),
      );
    } else {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.only(top: 5, bottom: 10),
        child: Column(
          children: [
            // Hình ảnh xe
            ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: my_colors.primary,
              indicatorBackgroundColor: Colors.white,
              children: widget.bikeModel.listBikeImage
                  .map((imgs) => ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(imgs.imageUrl, fit: BoxFit.cover)))
                  .toList(),
              onPageChanged: (value) {},
              autoPlayInterval: 60000,
            ),
            // Thông tin chi tiết xe
            Padding(
              padding: EdgeInsets.all(15),
              child: Bookingdetail(
                bikeModel: widget.bikeModel,
                bookingModel: widget.bookingModel,
                isCustomerHistory: widget.isCustomerHistory,
                isCustomerHistoryDetail: widget.isCustomerHistoryDetail,
              ),
            ),
          ],
        ),
      );
    }
  }
}
