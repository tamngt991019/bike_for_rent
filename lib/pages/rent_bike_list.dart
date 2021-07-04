import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_get_map.dart';
import 'package:bike_for_rent/pages/rent_bike_detail.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/frame_text.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

class RentBikeList extends StatefulWidget {
  final UserModel userModel;
  final double inLatitude;
  final double inLongitude;
  RentBikeList({Key key, this.userModel, this.inLatitude, this.inLongitude})
      : super(key: key);

  @override
  _RentBikeListState createState() => _RentBikeListState();
}

class _RentBikeListState extends State<RentBikeList> {
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
          isShowBackBtn: true,
          bottomAppBar: null,
          onPressedBackBtn: () => helper.pushInto(
              context, BikeGetMap(userModel: widget.userModel), false),
        ),
        // Body app
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin gói thuê
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gói thuê: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      "100000 vnd / ngày",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: Card(
                          color: my_colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(0),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              iconSize: 20,
                              onPressed: () => helper.pushInto(
                                  context,
                                  RentBikeFilter(userModel: widget.userModel),
                                  false),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              // thông tin vị trí thuê
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FrameText(
                    title: "Địa chỉ hiện tại",
                    content: "Đây là nội dung địa chỉ",
                  )
                ],
              ),
              SizedBox(height: 10),
              // Danh sách xe
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Danh sách các xe phù hợp:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                // onTap: () => runApp(MaterialApp(home: RentBikeDetail())),
                onTap: () {
                  helper.pushInto(context, RentBikeDetail(), true);
                },
                child: BookingCard(
                  isCustomerHistory: false,
                  isCustomerHistoryDetail: false,
                ),
              ),
              BookingCard(
                isCustomerHistory: false,
                isCustomerHistoryDetail: false,
              ),
              BookingCard(
                isCustomerHistory: false,
                isCustomerHistoryDetail: false,
              ),
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 1,
          userModel: widget.userModel,
        ),
      ),
    );
  }
}
