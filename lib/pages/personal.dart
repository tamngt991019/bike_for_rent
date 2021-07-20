import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/login_valid.dart';
import 'package:bike_for_rent/pages/rent_bike_manager.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/widgets/bloc_btn.dart';
import 'package:bike_for_rent/widgets/bottom_bar.dart';
import 'package:bike_for_rent/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

class Personal extends StatefulWidget {
  final UserModel userModel;
  Personal({Key key, this.userModel}) : super(key: key);

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  String errorStr;

  Color cardColor = Colors.white;
  Color textColor = my_colors.primary;

  UserModel _userModel;
  UserService userService = new UserService();
  bool _isRenting;
  bool _isShowRentingControlBtn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userModel != null) {
      _userModel = widget.userModel;
      _isRenting = widget.userModel.isRenting;
      _isShowRentingControlBtn = widget.userModel.isRenting;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: (widget.userModel == null)
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
                            backgroundImage: (_userModel != null)
                                ? NetworkImage(_userModel.avatar)
                                : AssetImage(
                                    "lib/assets/images/avatar_logo.png",
                                  ),
                          ),
                          SizedBox(width: 20),
                          // tên người dùng và sđt
                          Expanded(
                            // tên người dùng
                            child: Text(
                              _userModel.fullName,
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
                          BlocButton(
                            title: "Thông tin cá nhân",
                            iconData: Icons.arrow_forward_ios,
                            color: my_colors.primary,
                            onClicked: () {},
                          ),
                          // Đăng ký cho thuê
                          if (!_userModel.ownerVerified)
                            BlocButton(
                              title: "Đăng ký cho thuê",
                              iconData: Icons.arrow_forward_ios,
                              color: my_colors.primary,
                              onClicked: () {
                                setState(() {
                                  _userModel.ownerVerified = true;
                                  userService.updateUserModel(
                                      _userModel.username,
                                      _userModel,
                                      widget.userModel.token);
                                });
                              },
                            ),
                          if (_userModel.ownerVerified)
                            Column(
                              children: [
                                BlocButton(
                                  title: ((!_isRenting) ? "Mở" : "Tắt") +
                                      " cho thuê xe",
                                  iconData: Icons.arrow_forward_ios,
                                  color: my_colors.primary,
                                  onClicked: showHideRentingControlBtn,
                                ),
                                if (_isShowRentingControlBtn)
                                  if (_userModel.isRenting)
                                    Column(
                                      children: [
                                        BlocButton(
                                          title: "Quản lý cho thuê",
                                          iconData: Icons.arrow_forward_ios,
                                          color: my_colors.primary,
                                          onClicked: () => helper.pushInto(
                                            context,
                                            RentBikeManager(
                                              tabIndex: 0,
                                              userModel: _userModel,
                                            ),
                                            true,
                                          ),
                                        ),
                                        BlocButton(
                                          title: "Xe của tôi",
                                          iconData: Icons.arrow_forward_ios,
                                          color: my_colors.primary,
                                          onClicked: () {},
                                        ),
                                        BlocButton(
                                          title: "Địa điểm giao xe của tôi",
                                          iconData: Icons.arrow_forward_ios,
                                          color: my_colors.primary,
                                          onClicked: () {},
                                        ),
                                      ],
                                    ),
                              ],
                            ),
                          BlocButton(
                            title: "Đăng xuất",
                            iconData: Icons.logout,
                            color: my_colors.danger,
                            onClicked: () =>
                                helper.pushInto(context, Home(), true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        // Bottom bar app
        bottomNavigationBar: BottomBar(
          bottomBarIndex: 3,
          userModel: _userModel,
        ),
      ),
    );
  }

  dynamic showNotificationDialog(String contentStr) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return NotificationDialog(
          title: "Thông báo",
          titleColor: my_colors.primary,
          content: contentStr,
        );
      },
    );
  }

  void showHideRentingControlBtn() {
    setState(() {
      if (!_isRenting) {
        _userModel.isRenting = true;
      } else {
        _userModel.isRenting = false;
      }
    });
    Future<bool> checkUpdate = userService.updateUserModel(
        _userModel.username, _userModel, widget.userModel.token);

    checkUpdate.then((value) {
      if (value) {
        showNotificationDialog(
          ((!_isRenting) ? "Mở" : "Tắt") + " chức năng cho thuê xe thành công",
        );
      } else {
        showNotificationDialog(
          ((!_isRenting) ? "Mở" : "Tắt") + " chức năng cho thuê xe thất bại",
        );
      }
      setState(() {
        _isRenting = _userModel.isRenting;
        _isShowRentingControlBtn = _userModel.isRenting;
      });
    });
  }
}
