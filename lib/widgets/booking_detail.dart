import 'package:flutter/material.dart';

class Bookingdetail extends StatelessWidget {
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  Bookingdetail({Key key, this.isCustomerHistory, this.isCustomerHistoryDetail})
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Thời gian thuê: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Expanded(
                    child:
                        Text("1 ngày 10 tiếng", style: TextStyle(fontSize: 15)),
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
