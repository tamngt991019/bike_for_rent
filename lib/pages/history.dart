import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history_detail.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/services/bike_service.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

class History extends StatefulWidget {
  final UserModel userModel;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  History({
    Key key,
    this.userModel,
    this.isCustomerHistory,
    this.isCustomerHistoryDetail,
  }) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // BookingModel _bookingModel;
  BookingService bookingService = new BookingService();
  List<BookingModel> bookingList;
  bool _isHistoryListEmpty = true;
  Future loadListCustomerBookingFinishedCanceled(String username) {
    if (bookingList == null) {
      bookingList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.getListCustomerBookingWithBikeFinishedCanceled(
            username, widget.userModel.token);
    futureCases.then((_bookingList) {
      if (this.mounted) {
        setState(() {
          this.bookingList = _bookingList;
          if (_bookingList != null && _bookingList.length > 0) {
            _isHistoryListEmpty = false;
          }
        });
      }
    });
    return futureCases;
  }

  BikeService bikeService = new BikeService();
  BikeModel bikeModel;
  Future getBikeById(String id) {
    if (bikeModel == null) {
      bikeModel = new BikeModel();
    }
    Future<BikeModel> futureCases =
        bikeService.getBikeById(id, widget.userModel.token);
    futureCases.then((model) {
      if (this.mounted) {
        setState(() {
          this.bikeModel = model;
          // print(userList.length);
        });
      }
    });
    return futureCases;
  }

  UserService userService = new UserService();
  UserModel userModel;
  Future getUserbyId(String id) {
    if (userModel == null) {
      userModel = null;
      print("null usermodel ??? history r???i n??");
    }
    Future<UserModel> futureCases =
        userService.getUserById(id, widget.userModel.token);
    futureCases.then((_userModel) {
      if (this.mounted) {
        setState(() {
          this.userModel = _userModel;
        });
      }
    });
    return futureCases;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar:
            Appbar(height: 50, titles: "l???ch s??? thu??", isShowBackBtn: false),
        // Body app
        body: (widget.userModel == null)
            ? LoginValid(
                currentIndex: 2,
                content: "Vui l??ng ????ng nh???p ????? xem l???ch s??? thu?? xe!",
              )
            : FutureBuilder(
                future: loadListCustomerBookingFinishedCanceled(
                    widget.userModel.username),
                builder: (context, snapshot) {
                  return (!snapshot.hasData)
                      ?
                      // if (_isHistoryListEmpty) {
                      getEmptyScreen("Kh??ng c?? l???ch s??? cho thu?? xe")
                      // }
                      : SingleChildScrollView(
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: bookingList == null
                                    ? 0
                                    : bookingList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () => helper.pushInto(
                                      context,
                                      HistoryDetail(
                                        userModel: widget.userModel,
                                        bookingModel: bookingList[index],
                                        isCustomer: true,
                                      ),
                                      true,
                                    ),
                                    child: BookingCard(
                                      bookingModel: bookingList[index],
                                      bikeModel: bookingList[index].bikeModel,
                                      isCustomerHistory:
                                          widget.isCustomerHistory,
                                      isCustomerHistoryDetail:
                                          widget.isCustomerHistoryDetail,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                },
              ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 2,
          userModel: widget.userModel,
        ),
      ),
    );
  }

  Widget getEmptyScreen(String content) {
    return Center(
      child: Text(
        content,
        style: TextStyle(
          fontSize: 20,
          color: my_colors.primary,
        ),
      ),
    );
  }
}
