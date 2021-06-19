import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class RentBikeList extends StatefulWidget {
  final double inLatitude;
  final double inLongitude;
  RentBikeList({Key key, this.inLatitude, this.inLongitude}) : super(key: key);

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
            titles: "Titles text",
            isShowBackBtn: true,
            bottomAppBar: null,
            onPressedBackBtn: () {}),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(0),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              iconSize: 20,
                              onPressed: () {},
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Địa chỉ hiện tại:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "_currentAddress",
                          style: TextStyle(fontSize: 14),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
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
              BookingCard(
                isCustomerHistory: false,
                isCustomerHistoryDetail: false,
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
        // bottomNavigationBar: BottomBar(
        //   bottomBarIndex: 1,
        // ),
      ),
    );
  }
}
