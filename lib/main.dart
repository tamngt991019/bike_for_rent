import 'package:bike_for_rent/pages/login_screen.dart';
import 'package:bike_for_rent/pages/profile/profile_screen.dart';
import 'package:bike_for_rent/pages/return_bike_map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}