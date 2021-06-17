import 'package:flutter/material.dart';

class LoginSreen extends StatefulWidget {
  const LoginSreen({Key key}) : super(key: key);

  @override
  _LoginSreenState createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),

      home: Scaffold(
        body:
          SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

               children: <Widget>[
                Text(

                  "Đăng nhập",
                  style: TextStyle(fontWeight: FontWeight.bold,height: 5, fontSize: 24),
              // style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
                ),

               Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    width: 320,
                    height: 67,
                    decoration: BoxDecoration(color: Colors.black12,
                    borderRadius: BorderRadius.circular(29),
                  ),
                   child:
                     TextField(
                       onChanged: (value){
                       },
                     decoration: InputDecoration(
                       icon: Icon(
                         Icons.person,
                       ),
                       hintText: "Username",
                     ),
                   ),

               ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              width: 320,
              height: 67,
              decoration: BoxDecoration(color: Colors.black12,
                borderRadius: BorderRadius.circular(29),
              ),
              child:
              TextField(
                onChanged: (value){
                },
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                  ),
                  hintText: "Password",
                    suffixIcon: Icon(
                      Icons.visibility,
                    )
                ),
              ),
            ),
                 Container(
                     margin: EdgeInsets.symmetric(vertical: 10),
                     width: 280,
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(29),
                       child: FlatButton(
                         padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                         color: Colors.greenAccent,
                         //onPressed: press(),
                         onPressed: (){},
                         child: Text("Đăng nhập",
                             style: TextStyle(color: Colors.black)),
                       ),
                     )
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text(
                        "Bạn chưa có tài khoản? ",
                       style: TextStyle(color: Colors.black),
                     ),
                     GestureDetector(
                       onTap: (){},
                       child: Text(
                          "Đăng ký" ,
                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     )
                   ],
                 )

              ],
            ),
          )
        )
        );
  }
}


