import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/renting_card.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

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
              onPressedBackBtn: () {},
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
            // bottomNavigationBar: BottomBar(
            //   bottomBarIndex: 3,
            // ),
          ),
        ));
  }
}
