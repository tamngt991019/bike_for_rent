// import 'package:bike_for_rent/pages/test.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int bottomBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      currentIndex: bottomBarIndex,
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
        setState(() {
          bottomBarIndex = index;
          if (index == 0) {
            // runApp(Test());
          } else if (index == 1) {
            // runApp(Test());
          } else if (index == 2) {
            // runApp(Test());
          } else if (index == 3) {
            // runApp(Test());
          }
        });
      },
    );
  }
}
