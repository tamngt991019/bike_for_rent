// import 'package:bike_for_rent/models/user_model.dart';
// import 'package:bike_for_rent/services/user_service.dart';
// import 'package:bike_for_rent/test_api/test.dart';
// import 'package:bike_for_rent/widgets/app_bar.dart';
// import 'package:bike_for_rent/widgets/elevate_btn.dart';
// import 'package:flutter/material.dart';
// import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;

// class Add extends StatefulWidget {
//   const Add({Key key}) : super(key: key);

//   @override
//   _AddState createState() => _AddState();
// }

// class _AddState extends State<Add> {
//   UserService userService = new UserService();
//   UserModel userModel;
//   final _addFormKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       userModel = new UserModel(
//         username: "zzz",
//         fullName: "Cuời cl nha",
//         status: "ACTIVE",
//       );
//     });
//   }

//   bool isError = false;
//   bool isSuccess = false;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: my_colors.materialPimary,
//       ),
//       home: Scaffold(
//         // Header app
//         appBar: Appbar(
//             height: 50,
//             titles: "Thông tin cá nhân",
//             isShowBackBtn: true,
//             bottomAppBar: null,
//             onPressedBackBtn: () {
//               setState(() {
//                 runApp(Test());
//               });
//             }),
//         // Body app
//         body: Column(
//           children: [
//             Text(userModel.username),
//             Text(userModel.fullName),
//             Text(userModel.userVerified.toString()),
//             Text(userModel.ownerVerified.toString()),
//             Text(userModel.isRenting.toString()),
//             Text(userModel.status),
//             ElevatedButton(
//               onPressed: () {
//                 Future<UserModel> checkFuture =
//                     userService.createUser(userModel, userModel.token);
//                 checkFuture.then((value) {
//                   setState(() {
//                     if (value != null) {
//                       isError = false;
//                       isSuccess = true;
//                     } else {
//                       isError = true;
//                       isSuccess = false;
//                     }
//                   });
//                 });
//               },
//               child: Text("Add now"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Future<bool> checkFuture =
//                     userService.updateUserModel(userModel.username, userModel, userModel.token);
//                 checkFuture.then((value) {
//                   setState(() {
//                     if (value) {
//                       isError = false;
//                       isSuccess = true;
//                     } else {
//                       isError = true;
//                       isSuccess = false;
//                     }
//                   });
//                 });
//               },
//               child: Text("Update now"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Future<bool> checkFuture =
//                     userService.deleteUser(userModel.username, userModel.token);
//                 checkFuture.then((value) {
//                   setState(() {
//                     if (value) {
//                       isError = false;
//                       isSuccess = true;
//                     } else {
//                       isError = true;
//                       isSuccess = false;
//                     }
//                   });
//                 });
//               },
//               child: Text("Deleta now"),
//             ),
//             if (isError) Text("Thao tác thất con mẹ nó bại rồi!"),
//             if (isSuccess) Text("Thao tác thành công rồi đó ku"),
//           ],
//         ),
//       ),
//     );
//   }
// }
