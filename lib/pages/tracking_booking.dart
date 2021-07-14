import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_manager.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/outline_btn.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

// import 'package:dropdown_plus/dropdown_plus.dart';

class TrackingBooking extends StatefulWidget {
  final UserModel userModel;
  final BookingModel bookingModel;
  final bool isCustomer;
  final int tabIndex;
  TrackingBooking({
    Key key,
    this.userModel,
    this.bookingModel,
    this.isCustomer,
    this.tabIndex,
  }) : super(key: key);

  @override
  _TrackingBookingState createState() => _TrackingBookingState();
}

class _TrackingBookingState extends State<TrackingBooking> {
  List<String> imageUrls = [
    "https://media.publit.io/file/BikeForRent/banner/banner1.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner2.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner3.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner4.jpg",
    "https://media.publit.io/file/BikeForRent/banner/banner5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: Appbar(
          height: 50,
          titles: "Thuê xe",
          isShowBackBtn: (widget.isCustomer) ? false : true,
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
              context,
              RentBikeManager(
                userModel: widget.userModel,
                tabIndex: widget.tabIndex,
              ),
              false),
        ),
        // Body app
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Ten người dùng, sđt, avatar
              Card(
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
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                            ),
                            SizedBox(width: 20),
                            // tên người dùng và sđt
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  // tên người dùng
                                  Text(
                                    "Tên người thuê / cho thuê",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // sđt
                                  Text("Số điện thoại: " + "0987654321",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ))
                                ]))
                          ]))),
              SizedBox(height: 5),
              // Thông tin xe máy
              BookingCard(
                isCustomerHistory: false,
                isCustomerHistoryDetail: false,
              ),

              SizedBox(height: 10),
              // Thông tin địa điểm
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Địa điểm nhận / giao xe:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Text(
                                        "123 Trần Hưng Đạo, quận 1, thành phố Hồ Chí Mính",
                                        style: TextStyle(fontSize: 15),
                                        // textDirection: ,
                                      ),
                                      Divider(
                                        height: 10,
                                        color: Colors.black,
                                      ),
                                      // Địa điểm trả / lấy xe
                                      SizedBox(height: 15),
                                      Text("Địa điểm trả / lấy xe:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Text(
                                        "123 Trần Hưng Đạo, quận 1, thành phố Hồ Chí Mính",
                                        style: TextStyle(fontSize: 15),
                                        // textDirection: ,
                                      ),
                                      Divider(
                                        height: 10,
                                        color: Colors.black,
                                      )
                                    ])))
                      ])),
              SizedBox(height: 10),
              // Gói thuê
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gói thuê: ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text("100000 vnd / ngày",
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
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text("1 ngày 10 tiếng 30 phút",
                                style: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Trạng thái: ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(
                                "Đang xử lý / hủy / thuê / trả xe / thanh toán",
                                style: TextStyle(
                                    fontSize: 15, color: my_colors.danger)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thanh toán: ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),
                      DropdownSearch<String>(
                        mode: Mode.BOTTOM_SHEET,
                        showSelectedItem: true,
                        items: ["Tiền mặt", "Momo"],
                        // label: "Menu mode",
                        hint: "country in menu mode",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: "Tiền mặt",
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Expanded(
                      //       child: TextDropdown(
                      //         options: ["Tiền mặt", "Ví điện tử Momo"],
                      //         decoration: InputDecoration(
                      //             border: OutlineInputBorder(),
                      //             suffixIcon: Icon(Icons.arrow_drop_down),
                      //             labelText: "Hình thức thanh toán"),
                      //         dropdownHeight: 100,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Các nút cập nhật trạng thái của booking
              // các nút của người thuê
              if (widget.isCustomer)
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElavateBtn(
                        width: 180,
                        title: 'Đã nhận xe',
                        onPressedElavateBtn: () {},
                      ),
                      SizedBox(width: 20),
                      OutlineBtn(
                        width: 180,
                        title: 'Hủy thuê xe',
                        onPressedOutlineBtn: () {
                          // showConfirmDialog(
                          //   "Huỷ thuê xe",
                          //   "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                          //   RentBikeManager(
                          //     userModel: widget.userModel,
                          //     tabIndex: 0,
                          //   ),
                          //   null,
                          // );
                        },
                      )
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElavateBtn(
                        width: 380,
                        title: 'Yêu cầu trả xe',
                        onPressedElavateBtn: () {},
                      )
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElavateBtn(
                        width: 380,
                        title: 'Thanh toán',
                        onPressedElavateBtn: () {},
                      )
                    ]),
                  ],
                ),
              // các nút của chủ xe
              if (!widget.isCustomer)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElavateBtn(
                          width: 180,
                          title: 'Đồng ý cho thuê',
                          onPressedElavateBtn: () {},
                        ),
                        SizedBox(width: 20),
                        OutlineBtn(
                          width: 180,
                          title: 'Từ chối cho thuê',
                          onPressedOutlineBtn: () {
                            showConfirmDialog(
                              "Từ chối cho thuê",
                              "Bạn có muốn từ chối yêu cầu thuê này không?",
                              RentBikeManager(
                                userModel: widget.userModel,
                                tabIndex: 0,
                              ),
                              null,
                            );
                            // showConfirmDialog(
                            //   "Huỷ thuê xe",
                            //   "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                            //   RentBikeManager(
                            //     userModel: widget.userModel,
                            //     tabIndex: 0,
                            //   ),
                            // );
                          },
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElavateBtn(
                        width: 380,
                        title: 'Đã nhận xe',
                        onPressedElavateBtn: () {},
                      )
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElavateBtn(
                        width: 380,
                        title: 'Xác nhận đã thanh toán',
                        onPressedElavateBtn: () {},
                      )
                    ]),
                  ],
                ),

              //===========================================
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: (widget.isCustomer) ? 1 : 3,
        ),
      ),
    );
  }

  dynamic showConfirmDialog(String titleStr, String contentStr,
      Widget confirmWidget1, Widget confirmWidget2) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            titleStr,
            style: TextStyle(fontSize: 20),
          ),
          content: Text(
            contentStr,
            style: TextStyle(fontSize: 17),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          actions: [
            TextButton(
              child: Text(
                "Đồng ý",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                helper.pushInto(context, confirmWidget1, false);
              },
            ),
            TextButton(
              child: Text(
                "Huỷ",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }
}
