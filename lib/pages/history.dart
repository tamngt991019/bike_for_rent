import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/booking_card.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class History extends StatelessWidget {
  History({Key key}) : super(key: key);

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
            children: [
              BookingCard(
                isCustomerHistory: true,
              ),
              SizedBox(height: 10),
              BookingCard(
                isCustomerHistory: true,
              ),
              SizedBox(height: 10),
              BookingCard(
                isCustomerHistory: true,
              ),
              SizedBox(height: 10),
              BookingCard(
                isCustomerHistory: true,
              ),
              SizedBox(height: 10),
              BookingCard(
                isCustomerHistory: true,
              ),
            ],
          ),
        ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
