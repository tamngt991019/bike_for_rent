import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history_detail.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/pages/tracking_booking.dart';
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
  BookingModel _bookingModel;
  int currentIndex = 0;
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      RentingCard(
                        wg: TrackingBooking(
                          tabIndex: 0,
                          userModel: widget.userModel,
                          bookingModel: _bookingModel,
                          isCustomer: false,
                        ),
                        isRequest: true,
                        isRenting: false,
                        isHistory: false,
                      ),
                    ],
                  ),
                ),
                // Đang cho thuê
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      RentingCard(
                        wg: TrackingBooking(
                          tabIndex: 1,
                          userModel: widget.userModel,
                          bookingModel: _bookingModel,
                          isCustomer: false,
                        ),
                        isRequest: false,
                        isRenting: true,
                        isHistory: false,
                      ),
                    ],
                  ),
                ),
                // Lịch sử
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      RentingCard(
                        wg: HistoryDetail(
                          isCustomer: false,
                          userModel: widget.userModel,
                          bookingModel: _bookingModel,
                        ),
                        isRequest: false,
                        isRenting: false,
                        isHistory: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(
              bottomBarIndex: 3,
            ),
          ),
        ));
  }
}
