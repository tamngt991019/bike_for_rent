import 'package:bike_for_rent/constants/api_url.dart';
import 'package:bike_for_rent/models/bike_brand_model.dart';
import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/payment_type_model.dart';
import 'package:bike_for_rent/services/bike_brand_service.dart';
import 'package:bike_for_rent/services/bike_service.dart';
import 'package:bike_for_rent/services/bike_type_service.dart';
import 'package:bike_for_rent/services/payment_type_service.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Bookingdetail extends StatefulWidget {
  final BookingModel bookingModel;
  final BikeModel bikeModel;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  Bookingdetail({
    Key key,
    this.bookingModel,
    this.bikeModel,
    this.isCustomerHistory,
    this.isCustomerHistoryDetail,
  }) : super(key: key);

  @override
  _BookingdetailState createState() => _BookingdetailState();
}

class _BookingdetailState extends State<Bookingdetail> {
  BikeModel _bikeModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isCustomerHistory && !widget.isCustomerHistoryDetail) {
      _bikeModel = widget.bikeModel;
    } else {
      _bikeModel = widget.bookingModel.bikeModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tên xe
        Row(
          children: [
            Text("Tên xe: " + _bikeModel.model,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Loại xe: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          _bikeModel.bikeTypeModel.name,
                          style: TextStyle(fontSize: 15),
                          //   );
                          // },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hãng: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(
                          _bikeModel.bikeBrandModel.name,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Biển số xe: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(_bikeModel.licensePlates,
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Màu sắc: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(_bikeModel.color,
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.isCustomerHistory && widget.isCustomerHistoryDetail)
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ngày / giờ thuê xe: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(
                            DateTime.parse(widget.bookingModel.dateBegin)),
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ngày / giờ trả xe: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(
                            DateTime.parse(widget.bookingModel.dateEnd)),
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        if (widget.isCustomerHistory)
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isCustomerHistoryDetail)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Thời gian thuê: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text("2 ngày",
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (widget.isCustomerHistoryDetail) SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Trạng thái: ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                helper.getStatus(widget.bookingModel.eventTypeId
                                    .toUpperCase()),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: (widget.bookingModel.eventTypeId
                                              .toUpperCase() ==
                                          "CANCELED")
                                      ? my_colors.danger
                                      : my_colors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        if (widget.isCustomerHistory)
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Thanh toán: ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text("Tiền mặt",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Tổng tiền: ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text("123456 vnd",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

// }
int daysElapsedSince(DateTime from, DateTime to) {
// get the difference in term of days, and not just a 24h difference
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);

  return to.difference(from).inHours;
}
