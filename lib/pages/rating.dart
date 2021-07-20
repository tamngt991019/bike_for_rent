import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/notification_dialog.dart';
import 'package:bike_for_rent/widgets/outline_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Rating extends StatefulWidget {
  final UserModel userModel;
  final BookingModel bookingModel;
  Rating({Key key, this.userModel, this.bookingModel}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  dynamic ratingNum = 0.0;
  bool _isChoosedStar = false;
  final ratingContent = TextEditingController();
  bool _isEmptyContent = true;
  String errorStr = "";
  BookingModel _bookingModel;
  BookingService bookingService = new BookingService();
  void updateBookingEventType(BookingModel model) {
    Future<bool> futureCase = bookingService.updateBookingModel(
        model.id, model, widget.userModel.token);
    futureCase.then((isUpdateSuccess) {
      if (this.mounted) {
        if (!isUpdateSuccess) {
          showNotificationDialog(
            "Cảnh bảo!",
            "Thao tác thất bại, vui lòng thử lại! update even type",
            my_colors.danger,
          );
        } else {
          _isChoosedStar = true;
          _isEmptyContent = false;
        }
      }
    });
  }

  Future getBookingById(String id) async {
    if (_bookingModel == null) {
      _bookingModel = new BookingModel();
    }
    Future<BookingModel> futureCase =
        bookingService.getBookingById(id, widget.userModel.token);
    futureCase.then((model) {
      _bookingModel = model;
    });
    return futureCase;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
          // Header app
          appBar: AppBar(toolbarHeight: 0),
          // Body app
          body:
              // // FutureBuilder(
              // //   future: (widget.isCustomer)
              // //       ? loadListCustomerTrackingBooking()
              // //       : getOwnerTrackingBookingById(),
              //   builder: (context, snapshot) {
              // if (!_isLoadThisScreen) {
              // return
              Container(
            height: MediaQuery.of(context).size.height,
            color: my_colors.primary,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Đánh giá",
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  errorStr,
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            RatingStars(
                              value: ratingNum,
                              onValueChanged: (val) {
                                setState(() {
                                  ratingNum = val;
                                });
                              },
                              starBuilder: (index, color) => Icon(
                                Icons.star,
                                color: color,
                                size: 50,
                              ),
                              starSize: 50,
                              starCount: 5,
                              maxValue: 5,
                              starSpacing: 5,
                              valueLabelVisibility: false,
                              starOffColor: Colors.grey,
                              starColor: Colors.yellow,
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: ratingContent,
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  labelText: "Nội dung đánh giá"),
                              style: TextStyle(fontSize: 20),
                              onChanged: (val) {},
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElavateBtn(
                                  width: 150,
                                  title: 'Gửi đánh giá',
                                  onPressedElavateBtn: () {
                                    if (ratingNum > 0 &&
                                        (ratingContent.text.isEmpty == false ||
                                            ratingContent.text != null)) {
                                    } else {
                                      errorStr =
                                          "Vui lòng nhập sô sao và nội dung đánh giá";
                                    }
                                  },
                                ),
                                SizedBox(width: 20),
                                OutlineBtn(
                                    width: 150,
                                    title: 'Bỏ qua',
                                    onPressedOutlineBtn: () {}),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            // );
            // },
          )
          // Bottom bar app
          // bottomNavigationBar: BottomBar(
          //   bottomBarIndex: 1,
          // ),
          ),
    );
  }

  // hien thi thong bao
  dynamic showNotificationDialog(
      String titleStr, String contentStr, Color titleCColor) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return NotificationDialog(
          title: titleStr,
          titleColor: titleCColor,
          content: contentStr,
        );
      },
    );
  }
}
