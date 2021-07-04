import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/login.dart';
import 'package:bike_for_rent/pages/rent_bike_detail.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/pages/rent_bike_list.dart';
import 'package:bike_for_rent/test_api/test.dart';
import 'package:bike_for_rent/test_api/test_add.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      // initialRoute: '/RentBikeFilter',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/Home': (context) => Home(),
      //   // When navigating to the "/second" route, build the SecondScreen widget.
      //   '/RentBikeFilter': (context) => RentBikeFilter(),
      // },
    ));
