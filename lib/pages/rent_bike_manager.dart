import 'package:bike_for_rent/pages/test.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

import 'package:flutter_point_tab_bar/pointTabIndicator.dart';

class RentBikeManager extends StatefulWidget {
  RentBikeManager({Key key}) : super(key: key);

  @override
  _RentBikeManagerState createState() => _RentBikeManagerState();
}

class _RentBikeManagerState extends State<RentBikeManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: my_colors.materialPimary,
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            // Header app
            appBar: Appbar(
              height: 100,
              titles: "Quản lý cho thuê xe",
              isShowBackBtn: true,
              bottomAppBar: TabBar(
                tabs: [
                  Tab(text: "Yêu cầu"),
                  Tab(text: "Đang cho thuê"),
                  Tab(text: "Lịch sử"),
                ],
              ),
              onPressedBackBtn: () {
                runApp(Test(isTestPage: false));
              },
            ),
            // Body app
            body: TabBarView(
              children: [
                // Yêu cầu
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Card(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // avatar
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                                    ),
                                    SizedBox(width: 20),
                                    // tên người dùng và sđt
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          // tên người dùng
                                          Text(
                                            "Tên người thuê",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // sđt
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "0987654321",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "Xe số / tay ga",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "59X2-12345",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          // Địa điểm giao xe
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Địa điểm giao xe: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "123 Trần Hưng Đạo, phường 14, huyện Bình Chánh, Tp. Hồ Chí Minh",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "100000 vnd / ngày",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]))
                                  ]))),
                      Card(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          borderOnForeground: true,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // avatar
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                                    ),
                                    SizedBox(width: 20),
                                    // tên người dùng và sđt
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          // tên người dùng
                                          Text(
                                            "Tên người thuê",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // sđt
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "0987654321",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "Xe số / tay ga",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "59X2-12345",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          // Địa điểm giao xe
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Địa điểm giao xe: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "123 Trần Hưng Đạo, phường 14, huyện Bình Chánh, Tp. Hồ Chí Minh",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "100000 vnd / ngày",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]))
                                  ]))),
                      Card(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          borderOnForeground: true,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // avatar
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                                    ),
                                    SizedBox(width: 20),
                                    // tên người dùng và sđt
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          // tên người dùng
                                          Text(
                                            "Tên người thuê",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // sđt
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "0987654321",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "Xe số / tay ga",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "59X2-12345",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          // Địa điểm giao xe
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Địa điểm giao xe: ",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "123 Trần Hưng Đạo, phường 14, huyện Bình Chánh, Tp. Hồ Chí Minh",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  "100000 vnd / ngày",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]))
                                  ]))),
                    ],
                  ),
                ),
                // Đang cho thuê
                SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [],
                  ),
                ),
                // Lịch sử
                SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(),
          ),
        ));
  }
}
