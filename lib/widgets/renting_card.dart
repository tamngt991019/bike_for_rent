import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class RentingCard extends StatefulWidget {
  final BookingModel bookingModel;
  final Widget wg;
  final bool isRequest;
  final bool isRenting;
  final bool isHistory;
  final bool isTracking;
  final bool isShowNoti;
  const RentingCard({
    Key key,
    this.bookingModel,
    this.wg,
    this.isRequest,
    this.isRenting,
    this.isHistory,
    this.isTracking,
    this.isShowNoti,
  }) : super(key: key);

  @override
  _RentingCardState createState() => _RentingCardState();
}

class _RentingCardState extends State<RentingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!widget.isShowNoti) {
          helper.pushInto(context, widget.wg, true);
        } else {
          showNotificationDialog(
            "Thông báo!",
            "Vui lòng hoàn thành các yêu cầu đang xử lý trước khi nhận yêu cầu mới",
            my_colors.primary,
          );
        }
      },
      child: Card(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // avatar
              CircleAvatar(
                radius: 35,
                backgroundImage: (widget.bookingModel.userModel.avatar != null)
                    ? NetworkImage(widget.bookingModel.userModel.avatar)
                    : AssetImage(
                        "lib/assets/images/avatar_logo.png",
                      ),
              ),
              SizedBox(width: 20),
              // tên người dùng và sđt
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // tên người dùng
                    Text(
                      widget.bookingModel.userModel.fullName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // sđt
                    if (widget.bookingModel.userModel.phone != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Số điện thoại: ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              widget.bookingModel.userModel.phone,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 10),
                    // Loại xe
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Loại xe: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.bookingModel.bikeModel.bikeTypeModel.name,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Biển số xe
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Biển số xe: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.bookingModel.bikeModel.licensePlates,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Gói thuê
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gói thuê: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.bookingModel.payPackageModel.name,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //isRequest
                    if (widget.isRequest)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          // Địa điểm giao xe
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Địa điểm giao xe: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.bookingModel.locationGetBikeModel
                                          .address,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                    //isRenting
                    if (widget.isRenting)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          // Ngày giờ thuê
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ThờI gian thuê: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  helper.getDayElapsed(
                                      widget.bookingModel.dateBegin,
                                      DateTime.now().toString()),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    // isHistory
                    if (widget.isHistory)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          // Tổng tiền
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tổng tiền: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  helper.getPriceTotalStr(
                                        widget.bookingModel.dateBegin,
                                        widget.bookingModel.dateEnd,
                                        widget.bookingModel.bikeModel
                                            .bikeTypeModel.id,
                                        widget.bookingModel.payPackageModel,
                                      ) +
                                      " VND",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (widget.isHistory || widget.isTracking)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          // Thời gian thuê
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trạng thái: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.bookingModel.eventTypeModel.name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: (widget.bookingModel.eventTypeId ==
                                              "CANCELED")
                                          ? my_colors.danger
                                          : my_colors.primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
