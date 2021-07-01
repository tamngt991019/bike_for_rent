import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/login.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/pages/rent_bike_filter.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class Personal extends StatelessWidget {
  final UserModel userModel;
  Personal({Key key, this.userModel}) : super(key: key);

  final double _marginBottom = 5;

  final Color cardColor = Colors.white;
  final Color textColor = my_colors.primary;

// class Personal extends StatefulWidget {
//   const Personal({Key key}) : super(key: key);

//   @override
//   _PersonalState createState() => _PersonalState();
// }

// class _PersonalState extends State<Personal> {
//   double _marginBottom = 10;

  @override
  Widget build(BuildContext context) {
    // final double btnWWidth = MediaQuery.of(context).size.width * 90 / 100;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        // Header app
        appBar: AppBar(
          toolbarHeight: 0,
          //   title:
        ),
        // Body app
        body: (userModel == null)
            ? LoginValid(
                currentIndex: 3,
                content: "Vui lòng đăng nhập để xem thông tin!",
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        children: [
                          // avatar
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                "https://media.publit.io/file/BikeForRent/test_avatar.jpg"),
                          ),
                          SizedBox(width: 20),
                          // tên người dùng và sđt
                          Expanded(
                            // tên người dùng
                            child: Text(
                              "username",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35),
                    Center(
                      child: Column(
                        children: [
                          // thông tin cá nhân btn
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.primary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Thông tin cá nhân",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.primary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: my_colors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.primary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Đăng ký cho thuê",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.primary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: my_colors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.primary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Mở / tắt cho thuê xe",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.primary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: my_colors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.primary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Quản ý cho thuê",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.primary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: my_colors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.primary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Xe của tôi",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.primary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: my_colors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.primary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Địa điểm giao xe của tôi",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.primary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: my_colors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: _marginBottom),
                            child: InkWell(
                              highlightColor: my_colors.danger,
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 45, right: 45),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Đăng xuất",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: my_colors.danger),
                                        ),
                                      ),
                                      Icon(
                                        Icons.logout,
                                        color: my_colors.danger,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 0,
          userModel: userModel,
        ),
      ),
    );
  }
}
