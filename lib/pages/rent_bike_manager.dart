import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/card_bike.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

import 'package:flutter_point_tab_bar/pointTabIndicator.dart';

class RentBikeManager extends StatefulWidget {
  const RentBikeManager({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CardBike(),
                      CardBike(),
                      CardBike(),
                      CardBike(),
                      CardBike(),
                    ],
                  ),
                ),
                // Đang cho thuê
                SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CardBike(),
                      CardBike(),
                      CardBike(),
                      CardBike(),
                      CardBike(),
                    ],
                  ),
                ),
                // Lịch sử
                SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CardBike(),
                      CardBike(),
                      CardBike(),
                      CardBike(),
                      CardBike(),
                    ],
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
