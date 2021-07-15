import 'package:bike_for_rent/models/bike_brand_model.dart';
import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/event_type_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/rent_bike_manager.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/booking_detail.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/outline_btn.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

// import 'package:dropdown_plus/dropdown_plus.dart';

class TrackingBooking extends StatefulWidget {
  final UserModel userModel;
  // final BookingModel bookingModel;
  final bool isCustomer;
  final bool isShowBackBtn;
  final int tabIndex;
  TrackingBooking({
    Key key,
    this.userModel,
    // this.bookingModel,
    this.isCustomer,
    this.isShowBackBtn,
    this.tabIndex,
  }) : super(key: key);

  @override
  _TrackingBookingState createState() => _TrackingBookingState();
}

class _TrackingBookingState extends State<TrackingBooking> {
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

  BookingService bookingService = new BookingService();
  BookingModel mainBooking1;
  BookingModel mainBooking = new BookingModel(
    id: "5F14BD9C-F388-4F91-8585-6472737E0796",
    bikeId: "BIKE20",
    payPackageId: "PPKXS24",
    dateCreated: "2021-07-14T03:09:36.137",
    locationGetBike: "HCMLOC5",
    eventTypeId: "PROCESSING",
    bikeModel: BikeModel(
      id: "BIKE20",
      username: "owner2",
      brandId: "BRAND1",
      model: "SIRIUS",
      color: "Đen",
      licensePlates: "52X1-345.67",
      typeId: "XS",
      locationId: "OWNERLOC2",
      isBooking: false,
      isRentingEnable: true,
      status: "ACTIVE",
      bikeTypeModel: BikeTypeModel(
        id: "XS",
        name: "Xe số",
      ),
      bikeBrandModel: BikeBrandModel(
        id: "BRAND1",
        name: "Yamaha",
      ),
      listBikeImage: [],
    ),
    eventTypeModel: EventTypeModel(
      id: "PROCESSING",
      name: "Đang xử lý",
    ),
    locationGetBikeModel: LocationModel(
        id: "HCMLOC5",
        name: "KFC Hiệp Bình",
        address:
            "173 đường Hiệp Bình, Hiệp Bình Chánh, Thủ Đức, Thành phố Hồ Chí Minh, Vietnam",
        areaId: "AHCM01",
        locationTypeId: "LOCTY9",
        latitude: "10.842592143108645",
        longitude: "106.73129533471955",
        isShipPoint: true),
    payPackageModel: PayPackageModel(
        id: "PPKXS24",
        name: "100000 / 24 giờ",
        description: "Giá xe số 24 giờ",
        price: 100000,
        bikeTypeId: "XS"),
  );
  Future loadListTrackingBooking() {
    if (mainBooking == null) {
      mainBooking = new BookingModel();
    }
    Future<List<BookingModel>> futureCase =
        bookingService.getCustomerBookingsTracking(widget.userModel.username);
    futureCase.then((list) {
      setState(() {
        mainBooking = list.first;
      });
    });
    return futureCase;
  }

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
          isShowBackBtn: (widget.isCustomer) ? false : widget.isShowBackBtn,
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
            context,
            RentBikeManager(
              userModel: widget.userModel,
              tabIndex: widget.tabIndex,
            ),
            false,
          ),
        ),
        // Body app
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: loadListTrackingBooking(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  // Ten người dùng, sđt, avatar
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   shadowColor: my_colors.primary,
                  //   elevation: 5,
                  //   margin: EdgeInsets.all(10),
                  //   child:
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // avatar
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              (mainBooking.bikeModel.userModel.fullName != null)
                                  ? NetworkImage(
                                      mainBooking.bikeModel.userModel.avatar)
                                  : AssetImage(
                                      "lib/assets/images/avatar_logo.png",
                                    ),
                        ),
                        SizedBox(width: 20),
                        // tên người dùng và sđt
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // tên người dùng
                              Text(
                                (!widget.isCustomer)
                                    ? widget.userModel.fullName
                                    : mainBooking.bikeModel.userModel.fullName,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              // sđt
                              if (mainBooking.bikeModel.userModel.phone != null)
                                Text(
                                  "Số điện thoại: " +
                                      mainBooking.bikeModel.userModel.phone,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ),
                  // SizedBox(height: 5),
                  // Thông tin xe máy
                  // if (1 == 2)
                  // ImageSlideshow(
                  //   width: double.infinity,
                  //   height: 200,
                  //   initialPage: 0,
                  //   indicatorColor: my_colors.primary,
                  //   indicatorBackgroundColor: Colors.white,
                  //   children: imageUrls()
                  //       .map((img) => ClipRRect(
                  //           borderRadius: BorderRadius.only(
                  //               topLeft: Radius.circular(15),
                  //               topRight: Radius.circular(15)),
                  //           child: Image.network(img, fit: BoxFit.cover)))
                  //       .toList(),
                  //   onPageChanged: (value) {},
                  //   autoPlayInterval: 60000,
                  // ),
                  ImageSlideshow(
                    width: double.infinity,
                    height: 250,
                    initialPage: 0,
                    indicatorColor: my_colors.primary,
                    indicatorBackgroundColor: Colors.white,
                    children: imageUrls()
                        .map((img) => ClipRRect(
                            child: Image.network(img, fit: BoxFit.cover)))
                        .toList(),
                    onPageChanged: (value) {},
                    autoPlayInterval: 60000,
                  ),

                  Container(
                    margin: EdgeInsets.all(15),
                    child: Bookingdetail(
                      bikeModel: mainBooking.bikeModel,
                      bookingModel: mainBooking,
                      isCustomerHistory: false,
                      isCustomerHistoryDetail: false,
                    ),
                  ),

                  // SizedBox(height: 10),
                  // Thông tin địa điểm
                  if (1 == 2)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(
                    height: 10,
                    thickness: 0.5,
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  // SizedBox(height: 10),
                  // Gói thuê
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   elevation: 5,
                  //   child:
                  Padding(
                    padding: EdgeInsets.all(15),
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
                              child: Text(mainBooking.payPackageModel.name,
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
                              child: Text("Đang tính . . .",
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
                                mainBooking.eventTypeModel.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: my_colors.danger,
                                ),
                              ),
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
                  // ),
                  Divider(
                    height: 10,
                    thickness: 0.5,
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  SizedBox(height: 15),
                  // Các nút cập nhật trạng thái của booking
                  // các nút của người thuê
                  // if (widget.isCustomer)
                  Column(
                    children: [
                      if (mainBooking.eventTypeId == "OWNSHIPPEDBIKE")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 180,
                              title: 'Đã nhận xe',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "ARERENTING";
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            OutlineBtn(
                              width: 180,
                              title: 'Hủy thuê xe',
                              onPressedOutlineBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "CANCELED";
                                });

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
                          ],
                        ),
                      if (mainBooking.eventTypeId == "ARERENTING")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 380,
                              title: 'Yêu cầu trả xe',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "CUSRETURNBIKE";
                                });
                              },
                            )
                          ],
                        ),
                      if (mainBooking.eventTypeId == "OWNGOTBIKE")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 380,
                              title: 'Thanh toán',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "PAYING";
                                });
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                  // các nút của chủ xe
                  // if (!widget.isCustomer)
                  Column(
                    children: [
                      if (mainBooking.eventTypeId == "PROCESSING")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 180,
                              title: 'Đồng ý cho thuê',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "OWNSHIPPINGBIKE";
                                });
                              },
                            ),
                            SizedBox(width: 20),
                            OutlineBtn(
                              width: 180,
                              title: 'Từ chối cho thuê',
                              onPressedOutlineBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "CANCELED";
                                });

                                // showConfirmDialog(
                                //   "Từ chối cho thuê",
                                //   "Bạn có muốn từ chối yêu cầu thuê này không?",
                                //   RentBikeManager(
                                //     userModel: widget.userModel,
                                //     tabIndex: 0,
                                //   ),
                                //   null,
                                // );
                                // showConfirmDialog(
                                //   "Huỷ thuê xe",
                                //   "Bạn có muốn huỷ yêu cầu thuê xe này không?",
                                //   RentBikeManager(
                                //     userModel: widget.userModel,
                                //     tabIndex: 0,
                                //   ),
                                // );
                              },
                            ),
                          ],
                        ),
                      if (mainBooking.eventTypeId == "OWNSHIPPINGBIKE")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 380,
                              title: 'Đã giao xe',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "OWNSHIPPEDBIKE";
                                });
                              },
                            ),
                          ],
                        ),
                      // if (mainBooking.eventTypeId == "OWNSHIPPINGBIKE")
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       ElavateBtn(
                      //         width: 380,
                      //         title: 'Đã giao xe',
                      //         onPressedElavateBtn: () {
                      //           mainBooking.eventTypeId = "OWNSHIPPEDBIKE";
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      if (mainBooking.eventTypeId == "CUSRETURNBIKE")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 380,
                              title: 'Đã lấy xe',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "OWNGOTBIKE";
                                });
                              },
                            ),
                          ],
                        ),
                      if (mainBooking.eventTypeId == "PAYING")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElavateBtn(
                              width: 380,
                              title: 'Xác nhận thanh toán',
                              onPressedElavateBtn: () {
                                setState(() {
                                  mainBooking.eventTypeId = "PROCESSING";
                                });
                              },
                            )
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //===========================================
                ],
              );
            },
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: (widget.isCustomer) ? 1 : 3,
          userModel: widget.userModel,
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

  // dynamic showDropdownPayment(context) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         title: Text(
  //           "Chọn loại xe:",
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         content: Container(
  //           width: 1, // Cho nay khai bao de khong bi loi - Ly do : chua biet
  //           height: 100,
  //           child: FutureBuilder(
  //             future: loadListBikeTypes(),
  //             builder: (dialogContext, snapshot) {
  //               return ListView.builder(
  //                 itemCount: bikeTypeList == null ? 0 : bikeTypeList.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   var item = bikeTypeList[index];
  //                   return TextButton(
  //                     child: Text(
  //                       item.name,
  //                       style: TextStyle(
  //                         fontSize: 15,
  //                         color: (_bikeTypeModel != null &&
  //                                 item.id == _bikeTypeIdSelected)
  //                             ? my_colors.primary
  //                             : Colors.black,
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       setState(() {
  //                         _bikeTypeIdSelected = item.id;
  //                         _bikeTypeStr = item.name;
  //                         _bikeTypeColor = Colors.black;
  //                         _bikeTypeModel = item;
  //                         _ppkStr = "Chọn gói thuê:";
  //                       });
  //                       Navigator.pop(context);
  //                     },
  //                   );
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
