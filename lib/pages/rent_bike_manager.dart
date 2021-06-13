import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
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
                  Tab(text: "Hoàn thành"),
                ],
              ),
              onPressedBackBtn: () {},
            ),
            // Body app
            body: TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
            // Bottom bar app
            bottomNavigationBar: BottomBar(),
          ),
        ));
  }
}
