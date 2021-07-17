import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history_detail.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/pages/tracking_booking.dart';
import 'package:bike_for_rent/services/booking_service.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/renting_card.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

class RentBikeManager extends StatefulWidget {
  final UserModel userModel;
  final int tabIndex;
  RentBikeManager({Key key, this.userModel, this.tabIndex}) : super(key: key);

  @override
  _RentBikeManagerState createState() => _RentBikeManagerState();
}

class _RentBikeManagerState extends State<RentBikeManager> {
  bool _isProcessListEmpty = true;
  bool _isAreRentingListEmpty = true;
  bool _isHistoryListEmpty = true;
  BookingModel _bookingModel;
  BookingService bookingService = new BookingService();
  List<BookingModel> bookingHistoryList;
  Future loadOwnerBookingHistoryList(String username) {
    if (bookingHistoryList == null) {
      bookingHistoryList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.ownerBookingHistoryList(username);
    futureCases.then((_bookingHistoryList) {
      if (this.mounted) {
        setState(() {
          this.bookingHistoryList = _bookingHistoryList;
          if (_bookingHistoryList != null && _bookingHistoryList.length > 0) {
            _isHistoryListEmpty = false;
          }
        });
      }
    });
    return futureCases;
  }

  //owner booking processing
  List<BookingModel> bookingProcessingList;
  Future loadOwnerBookingProcessingList(String username) {
    if (bookingProcessingList == null) {
      bookingProcessingList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.ownerBookingProcessingList(username);
    futureCases.then((_bookingProcessingList) {
      if (this.mounted) {
        setState(() {
          this.bookingProcessingList = _bookingProcessingList;
          if (_bookingProcessingList != null &&
              _bookingProcessingList.length > 0) {
            _isProcessListEmpty = false;
          }
        });
      }
    });
    return futureCases;
  }

  //owner booking are renting
  List<BookingModel> bookingAreRentingList;
  Future loadOwnerBookingAreRentingList(String username) {
    if (bookingAreRentingList == null) {
      bookingAreRentingList = [];
    }
    Future<List<BookingModel>> futureCases =
        bookingService.ownerBookingAreRentingList(username);
    futureCases.then((_bookingAreRentingList) {
      if (this.mounted) {
        setState(() {
          this.bookingAreRentingList = _bookingAreRentingList;
          if (_bookingAreRentingList != null &&
              _bookingAreRentingList.length > 0) {
            _isAreRentingListEmpty = false;
          }
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
        home: DefaultTabController(
          initialIndex: widget.tabIndex,
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
                helper.pushInto(
                    context, Personal(userModel: widget.userModel), false);
              },
            ),
            // Body app
            body: TabBarView(
              children: [
                // Yêu cầu
                FutureBuilder(
                  future:
                      loadOwnerBookingProcessingList(widget.userModel.username),
                  builder: (context, snapshot) {
                    if (_isProcessListEmpty) {
                      return getEmptyScreen("Không có yêu cầu thuê xe");
                    } else {
                      return SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: bookingProcessingList == null
                                  ? 0
                                  : bookingProcessingList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RentingCard(
                                  bookingModel: bookingProcessingList[index],
                                  wg: TrackingBooking(
                                    tabIndex: 0,
                                    userModel: widget.userModel,
                                    isCustomer: false,
                                  ),
                                  isRequest: true,
                                  isRenting: false,
                                  isHistory: false,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                // Đang cho thuê
                FutureBuilder(
                  future:
                      loadOwnerBookingAreRentingList(widget.userModel.username),
                  builder: (context, snapshot) {
                    if (_isAreRentingListEmpty) {
                      return getEmptyScreen("Không có xe đang cho thuê");
                    } else {
                      return SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ListView.builder(
                              itemCount: bookingAreRentingList == null
                                  ? 0
                                  : bookingAreRentingList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RentingCard(
                                  bookingModel: bookingAreRentingList[index],
                                  wg: TrackingBooking(
                                    tabIndex: 1,
                                    userModel: widget.userModel,
                                    isCustomer: false,
                                  ),
                                  isRequest: false,
                                  isRenting: true,
                                  isHistory: false,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                // Lịch sử
                FutureBuilder(
                  future:
                      loadOwnerBookingHistoryList(widget.userModel.username),
                  builder: (context, snapshot) {
                    if (_isHistoryListEmpty) {
                      return getEmptyScreen("Không có lịch sử cho thuê xe");
                    } else {
                      return SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: bookingHistoryList == null
                                  ? 0
                                  : bookingHistoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RentingCard(
                                  bookingModel: bookingHistoryList[index],
                                  wg: HistoryDetail(
                                    isCustomer: false,
                                    userModel: widget.userModel,
                                    bookingModel: _bookingModel,
                                  ),
                                  isRequest: false,
                                  isRenting: false,
                                  isHistory: true,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(
              bottomBarIndex: 3,
              userModel: widget.userModel,
            ),
          ),
        ));
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
