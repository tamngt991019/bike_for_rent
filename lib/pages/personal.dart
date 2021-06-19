import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

// class Personal extends StatelessWidget {
//   Personal({Key key}) : super(key: key);

//   double _marginBottom = 5;

//   Color cardColor = Colors.white;
//   Color textColor = my_colors.primary;
class Personal extends StatefulWidget {
  const Personal({Key key}) : super(key: key);

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  // @override
  // Widget build(BuildContext context) {
  //   return Container(

  //   );
  // }
// }
  double _marginBottom = 10;
  Color cardColor = Colors.white;
  Color textColor = my_colors.primary;
  @override
  Widget build(BuildContext context) {
    double btnWWidth = MediaQuery.of(context).size.width * 90 / 100;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Stack(
        children: [
          Scaffold(
            // Header app
            appBar: AppBar(
              toolbarHeight: 0,
              //   title:
            ),
            // Body app
            body: SingleChildScrollView(
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
                            highlightColor: textColor,
                            onHighlightChanged: (isChanged) {
                              setState(() {
                                if (isChanged) {
                                  cardColor = my_colors.primary;
                                  textColor = Colors.white;
                                } else {
                                  cardColor = Colors.white;
                                  textColor = my_colors.primary;
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(15),
                            onTap: () => runApp(MaterialApp(
                              home: Home(),
                            )),
                            child: Card(
                              color: cardColor,
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
                                            fontSize: 25, color: textColor),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: textColor,
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
                            onTap: () => runApp(MaterialApp(
                              home: Home(),
                            )),
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
            // bottomNavigationBar: BottomBar(
            //   bottomBarIndex: 0,
            // ),
          ),
        ],
      ),
    );
  }
}
