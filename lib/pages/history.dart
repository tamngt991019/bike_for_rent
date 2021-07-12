import 'package:bike_for_rent/models/booking_model.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history_detail.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

class History extends StatelessWidget {
  final UserModel userModel;
  final bool isCustomerHistory;
  final bool isCustomerHistoryDetail;
  History({
    Key key,
    this.userModel,
    this.isCustomerHistory,
    this.isCustomerHistoryDetail,
  }) : super(key: key);

  BookingModel _bookingModel;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar:
            Appbar(height: 50, titles: "lịch sử thuê", isShowBackBtn: false),
        // Body app
        body: (userModel == null)
            ? LoginValid(
                currentIndex: 2,
                content: "Vui lòng đăng nhập để xem lịch sử thuê xe!",
              )
            : SingleChildScrollView(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => helper.pushInto(
                          context,
                          HistoryDetail(
                            userModel: userModel,
                            bookingModel: _bookingModel,
                            isCustomer: true,
                          ),
                          true),
                      child: BookingCard(
                        isCustomerHistory: isCustomerHistory,
                        isCustomerHistoryDetail: isCustomerHistoryDetail,
                      ),
                    ),
                  ],
                ),
              ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 2,
          userModel: userModel,
        ),
      ),
    );
  }
}
