import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/test_api/test.dart';
import 'package:bike_for_rent/widgets/app_bar.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

class UserDetail extends StatefulWidget {
  final UserModel usermodel;
  const UserDetail({Key key, this.usermodel}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
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
            titles: "Thông tin cá nhân",
            isShowBackBtn: true,
            bottomAppBar: null,
            onPressedBackBtn: () {
              setState(() {
                runApp(Test());
              });
            }),
        // Body app
        body: SingleChildScrollView(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                margin: EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundImage: (widget.usermodel.avatar != null)
                                ? NetworkImage(widget.usermodel.avatar)
                                : AssetImage("lib/assets/images/default.png")),
                        SizedBox(width: 20),
                        // tên người dùng và sđt
                        Expanded(
                          child: Text(
                            widget.usermodel.username,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Tên day du: ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(widget.usermodel.fullName,
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Ngày đăng ký: ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(widget.usermodel.dateCreated.toString(),
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(children: [
                      Text("Trạng thái: ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(widget.usermodel.status,
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      )
                    ])
                  ]),
                ))),
        // Bottom bar app
        // bottomNavigationBar: BottomBar(bottomBarIndex: 3),
      ),
    );
  }
}
