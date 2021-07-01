// import 'package:bike_for_rent/pages/test.dart';
import 'package:bike_for_rent/constants/api_url.dart';
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/test_api/test.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int bottomBarIndex;
  final UserModel userModel;
  BottomBar({Key key, this.bottomBarIndex, this.userModel}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.bottomBarIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 30),
          activeIcon: Icon(Icons.home, size: 30),
          label: "Trang chủ",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.moped_outlined, size: 30),
          activeIcon: Icon(Icons.moped, size: 30),
          label: "Thuê xe",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet_outlined, size: 30),
          activeIcon: Icon(Icons.text_snippet, size: 30),
          label: "Lịch sử",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined, size: 30),
          activeIcon: Icon(Icons.person, size: 30),
          label: "Cá nhân",
        ),
      ],
      // press for switch tab
      onTap: (index) {
        if (index == 0) {
          runApp(MaterialApp(home: Home(userModel: widget.userModel)));
        } else if (index == 1) {
          runApp(
              MaterialApp(home: RentBikeFilter(userModel: widget.userModel)));
        } else if (index == 2) {
          runApp(MaterialApp(
              home: History(
            userModel: widget.userModel,
            isCustomerHistory: false,
            isCustomerHistoryDetail: false,
          )));
        } else if (index == 3) {
          runApp(MaterialApp(home: Personal(userModel: widget.userModel)));
        }
      },
    );
  }
}
