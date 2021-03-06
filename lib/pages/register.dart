import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/pages/login.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:bike_for_rent/helper/helper.dart' as helper;

class Register extends StatefulWidget {
  final UserModel userModel;
  final currentIndex;
  const Register({Key key, this.userModel, this.currentIndex})
      : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isEmptyFulname = false;
  final txtFullname = TextEditingController();
  bool isPhoneValid = true;
  final txtPhone = TextEditingController();
  String signupFail;
  UserService userService = new UserService();
  UserModel _userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userModel = widget.userModel;
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
                    helper.pushInto(context,
                        Login(currentIndex: widget.currentIndex), false);
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
                SizedBox(height: 130),
                Text(
                  "????ng k??",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController.fromValue(
                                    TextEditingValue(
                                        text: "????? c??i gmail ??? ????y"),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Gmail",
                                    enabled: false,
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
                              Expanded(
                                child: TextField(
                                  controller: txtFullname,
                                  decoration: InputDecoration(
                                    labelText: "T??n ?????y ?????",
                                    hintText: "T??n ?????y ?????",
                                    errorText: isEmptyFulname
                                        ? 'Vui l??ng nh???p t??n ?????y ?????'
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
                              Expanded(
                                child: TextField(
                                  controller: txtPhone,
                                  decoration: InputDecoration(
                                    labelText: "S??? ??i???n tho???i",
                                    hintText: "S??? ??i???n tho???i",
                                    errorText: isPhoneValid
                                        ? null
                                        : 'Vui l??ng nh???p s??? ??i???n tho???i ????ng ?????nh d???ng 0xxxxxxxxx',
                                  ),
                                  style: TextStyle(fontSize: 15),
                                  onChanged: (val) {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElavateBtn(
                            width: MediaQuery.of(context).size.width * .5,
                            title: "????ng k??",
                            onPressedElavateBtn: () {
                              setState(() {
                                isEmptyFulname =
                                    helper.isEmptyText(txtFullname.text);
                                isPhoneValid =
                                    helper.isPhoneFormatValid(txtPhone.text);
                                // if (isEmptyFulname == false &&
                                //     isPhoneValid == true) {
                                //   _userModel.fullName = txtFullname.text;
                                //   _userModel.phone = txtPhone.text;
                                //   Future<UserModel> userModelFuture =
                                //       userService.createUser(_userModel);
                                //   userModelFuture.then((model) {
                                //     setState(() {
                                //       if (model != null) {
                                //         _userModel = model;
                                //         helper.pushInto(
                                //           context,
                                //           Login(
                                //             currentIndex: widget.currentIndex,
                                //           ),
                                //           true,
                                //         );
                                //       } else {
                                //         signupFail =
                                //             "???? x??y ra l???i, vui l??ng th??? l???i!";
                                //       }
                                //     });
                                //   });
                                // }
                              });
                            },
                          ),
                          if (signupFail != null) SizedBox(height: 10),
                          if (signupFail != null)
                            Text(
                              signupFail,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
