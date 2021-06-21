import 'package:bike_for_rent/helper/helper.dart' as helper;
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';

import 'package:bike_for_rent/constants/my_colors.dart' as my_colors;
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isEmptyUsername = false;
  final txtUsername = TextEditingController();
  bool isEmptyPassword = false;
  final txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: my_colors.materialPimary,
      ),
      home: Container(
        color: my_colors.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Image.asset(
              "lib/assets/images/bfr_logo.png",
              width: 200,
              height: 200,
              color: Colors.white,
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              // height: MediaQuery.of(context).size.height * .4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 30, top: 10, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                            color: my_colors.primary,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: txtUsername,
                              decoration: InputDecoration(
                                labelText: "Tên đăng nhập",
                                hintText: "Tên đăng nhặp",
                                errorText: isEmptyUsername
                                    ? 'Không được bỏ trống'
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 30,
                            color: my_colors.primary,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: txtPassword,
                              decoration: InputDecoration(
                                labelText: "Mật khẩu",
                                hintText: "Mật khẩu",
                                errorText: isEmptyPassword
                                    ? 'Không được bỏ trống'
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
                        title: "Đăng nhập",
                        onPressedElavateBtn: () {
                          setState(() {
                            isEmptyUsername =
                                helper.checkEmptyText(txtUsername.text);
                            isEmptyPassword =
                                helper.checkEmptyText(txtPassword.text);
                          });
                        },
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
                  // Text(
                  //   "Or",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  // ),
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
                              "Đăng nhập với Google",
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
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(my_colors.secondary),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () {},
                ),
              ),
            ),
            // SignInButton(
            //   Buttons.Google,
            //   text: "Sign up with Google",
            //   onPressed: () {},
            // )
          ],
        ),
      ),
    );
  }
}

// class LoginSreen extends StatefulWidget {
//   const LoginSreen({Key key}) : super(key: key);

//   @override
//   _LoginSreenState createState() => _LoginSreenState();
// }

// class _LoginSreenState extends State<LoginSreen> {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(),

//       home: Scaffold(
//         body:
//           SingleChildScrollView(

//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,

//                children: <Widget>[
//                 Text(

//                   "Đăng nhập",
//                   style: TextStyle(fontWeight: FontWeight.bold,height: 5, fontSize: 24),
//               // style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
//                 ),

//                Container(
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//                     width: 320,
//                     height: 67,
//                     decoration: BoxDecoration(color: Colors.black12,
//                     borderRadius: BorderRadius.circular(29),
//                   ),
//                    child:
//                      TextField(
//                        onChanged: (value){
//                        },
//                      decoration: InputDecoration(
//                        icon: Icon(
//                          Icons.person,
//                        ),
//                        hintText: "Username",
//                      ),
//                    ),

//                ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 10),
//               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
//               width: 320,
//               height: 67,
//               decoration: BoxDecoration(color: Colors.black12,
//                 borderRadius: BorderRadius.circular(29),
//               ),
//               child:
//               TextField(
//                 onChanged: (value){
//                 },
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   icon: Icon(
//                     Icons.lock,
//                   ),
//                   hintText: "Password",
//                     suffixIcon: Icon(
//                       Icons.visibility,
//                     )
//                 ),
//               ),
//             ),
//                  Container(
//                      margin: EdgeInsets.symmetric(vertical: 10),
//                      width: 280,
//                      child: ClipRRect(
//                        borderRadius: BorderRadius.circular(29),
//                        child: FlatButton(
//                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
//                          color: Colors.greenAccent,
//                          //onPressed: press(),
//                          onPressed: (){},
//                          child: Text("Đăng nhập",
//                              style: TextStyle(color: Colors.black)),
//                        ),
//                      )
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                         "Bạn chưa có tài khoản? ",
//                        style: TextStyle(color: Colors.black),
//                      ),
//                      GestureDetector(
//                        onTap: (){},
//                        child: Text(
//                           "Đăng ký" ,
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      )
//                    ],
//                  )

//               ],
//             ),
//           )
//         )
//         );
//   }
// }
