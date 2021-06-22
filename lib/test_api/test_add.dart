import 'package:bike_for_rent/models/user_model.dart';
import 'package:bike_for_rent/services/user_service.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  UserService userService = new UserService();
  UserModel userModel;
  final _addFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userModel = new UserModel(
        // username: "testcustomer1",
        // password: null,
        // fullName: "Customer Number 1",
        // dateCreated: "2021-06-22T09:33:42.937",
        // email: null,
        // phone: null,
        username: "XXX",
        password: null,
        fullName: "Customer Number X",
        email: null,
        phone: null,
        avatar: null,
        dateCreated: null,
        userVerified: true,
        identityNo: null,
        frontIdentityImage: null,
        backIdentityImage: null,
        ownerVerified: false,
        isRenting: false,
        status: "ACTIVE",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(userModel.username),
            Text(userModel.fullName),
            Text(userModel.userVerified.toString()),
            Text(userModel.ownerVerified.toString()),
            Text(userModel.isRenting.toString()),
            Text(userModel.status),
            ElevatedButton(
              onPressed: () {
                userService.createUser(userModel);
              },
              child: Text("Add now"),
            )
          ],
        ),
      ),
    );
  }
}
