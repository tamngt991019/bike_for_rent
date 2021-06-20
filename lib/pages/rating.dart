import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:bike_for_rent/widgets/outline_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class Rating extends StatefulWidget {
  Rating({Key key}) : super(key: key);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double rating = 0;
  String contenInput = "";

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
            onPressedBackBtn: () {}),
        // Body app
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Đánh giá:",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              RatingStars(
                value: rating,
                onValueChanged: (val) {
                  setState(() {
                    rating = val;
                    print(rating);
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                  size: 50,
                ),
                starSize: 50,
                starCount: 5,
                maxValue: 5,
                starSpacing: 5,
                valueLabelVisibility: false,
                starOffColor: Colors.grey,
                starColor: Colors.yellow,
              ),
              SizedBox(height: 20),
              TextField(
                minLines: 1,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(labelText: "Nội dung đánh giá"),
                style: TextStyle(fontSize: 20),
                onChanged: (val) {
                  contenInput = val;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElavateBtn(
                    width: 150,
                    title: 'Gửi đánh giá',
                    onPressedElavateBtn: () => print(contenInput),
                  ),
                  SizedBox(width: 20),
                  OutlineBtn(
                      width: 150, title: 'Bỏ qua', onPressedOutlineBtn: () {}),
                ],
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
