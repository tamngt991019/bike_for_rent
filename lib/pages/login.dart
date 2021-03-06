import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/bike_get_map.dart';
import 'package:bike_for_rent/pages/history.dart';
import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/personal.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  final int currentIndex;
  const Login({Key key, this.currentIndex}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isEmptyUsername = false;
  final txtUsername = TextEditingController();
  bool isEmptyPassword = false;
  final txtPassword = TextEditingController();
  String loginFail;

  UserModel _userModel;

  Widget getScreen() {
    if (widget.currentIndex == 0) {
      return Home(userModel: _userModel);
    } else if (widget.currentIndex == 1) {
      return BikeGetMap(userModel: _userModel);
    } else if (widget.currentIndex == 2) {
      return History(
        userModel: _userModel,
        isCustomerHistory: false,
        isCustomerHistoryDetail: false,
      );
    } else if (widget.currentIndex == 3) {
      return Personal(userModel: _userModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: my_colors.primary,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    helper.pushInto(context, getScreen(), false);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Tr??? v???",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Image.asset(
                  "lib/assets/images/bfr_logo.png",
                  width: 200,
                  height: 200,
                  color: Colors.white,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 30, top: 10, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 35,
                                color: my_colors.primary,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: txtUsername,
                                  decoration: InputDecoration(
                                    labelText: "T??n ????ng nh???p",
                                    hintText: "T??n ????ng nh???p",
                                    errorText: isEmptyUsername
                                        ? 'Vui l??ng nh???p t??n ????ng nh???p'
                                        : null,
                                  ),
                                  style: TextStyle(fontSize: 15),
                                  onChanged: (val) {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                size: 35,
                                color: my_colors.primary,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: txtPassword,
                                  decoration: InputDecoration(
                                    labelText: "M???t kh???u",
                                    hintText: "M???t kh???u",
                                    errorText: isEmptyPassword
                                        ? 'Vui l??ng nh???p m???t kh???u'
                                        : null,
                                  ),
                                  obscureText: true,
                                  style: TextStyle(fontSize: 15),
                                  onChanged: (val) {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElavateBtn(
                            width: MediaQuery.of(context).size.width * .5,
                            title: "????ng nh???p",
                            onPressedElavateBtn: () {
                              setState(() {
                                isEmptyUsername =
                                    helper.isEmptyText(txtUsername.text);
                                isEmptyPassword =
                                    helper.isEmptyText(txtPassword.text);
                                if (isEmptyPassword == false &&
                                    isEmptyUsername == false) {
                                  Future<UserModel> userModelFuture =
                                      UserService().login(
                                          txtUsername.text, txtPassword.text);
                                  userModelFuture.then((value) {
                                    setState(() {
                                      if (value != null) {
                                        _userModel = value;
                                        helper.pushInto(
                                            context, getScreen(), true);
                                      } else {
                                        loginFail =
                                            "T??n ????ng nh???p ho???c m???t kh???u kh??ng ch??nh x??c";
                                      }
                                    });
                                  });
                                }
                              });
                            },
                          ),
                          if (loginFail != null) SizedBox(height: 10),
                          if (loginFail != null)
                            Text(
                              loginFail,
                              style: TextStyle(
                                fontSize: 15,
                                color: my_colors.danger,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.white,
                              thickness: 1.5,
                              indent: 55,
                              endIndent: 5,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "lib/assets/images/or.png",
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.white,
                              thickness: 1.5,
                              indent: 5,
                              endIndent: 55,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 45,
                  child: Center(
                    child: ElevatedButton(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "????ng nh???p v???i Google",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Image.asset(
                              "lib/assets/images/gg_logo.png",
                              width: 25,
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              my_colors.secondary),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      onPressed: () {},
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * .8,
                //   height: 45,
                //   child: SignInButton(
                //     Buttons.Google,
                //     text: "Sign up with Google",
                //     onPressed: () {},
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
