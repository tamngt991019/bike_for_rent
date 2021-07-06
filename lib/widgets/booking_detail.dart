import 'package:bike_for_rent/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class Bookingdetail extends StatelessWidget {
  final BookingModel bookingModel;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  Bookingdetail(
      {Key key,
      this.bookingModel,
      this.isCustomerHistory,
      this.isCustomerHistoryDetail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tên xe
        Row(
          children: [
            Text("Tên xe: " + "SIRIUS",
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
                        child: Text("Xe số / tay ga",
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Háng: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text("HONDA / YAMAHA",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Biển số xe: ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Expanded(
                        child:
                            Text("59X2-12345", style: TextStyle(fontSize: 15)),
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
                        child: Text("Đỏ đen", style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (isCustomerHistory && isCustomerHistoryDetail)
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
                    child: Text("30/12/2021 - 15:30",
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
                    child: Text("31/12/2021 - 15:30",
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCustomerHistory && isCustomerHistoryDetail)
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
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text("1 ngày 10 tiếng",
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (isCustomerHistory && isCustomerHistoryDetail)
                  SizedBox(width: 10),
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
                                // helper.getStatus(
                                //     bookingModel.status.toUpperCase()),
                                helper.getStatus("FINISHED"),
                                style: TextStyle(
                                  fontSize: 15,
                                  // color: (bookingModel.status == "CANCELED")
                                  //     ? my_colors.danger
                                  //     : my_colors.primary,
                                  color: ("FINISHED" == "CANCELED")
                                      ? my_colors.danger
                                      : my_colors.primary,
                                )),
                            // Text("Hoàn thành / Huỷ",
                            // style: TextStyle(fontSize: 15)),
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
        if (isCustomerHistory)
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
