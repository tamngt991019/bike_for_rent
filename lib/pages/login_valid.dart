import 'package:bike_for_rent/pages/login.dart';
import 'package:bike_for_rent/widgets/elevate_btn.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/helper/helper.dart' as helper;

class LoginValid extends StatelessWidget {
  final currentIndex;
  final String content;
  const LoginValid({Key key, this.currentIndex, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            content,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElavateBtn(
              width: 200,
              title: 'Đăng nhập',
              onPressedElavateBtn: () => helper.pushInto(
                  context, Login(currentIndex: currentIndex), true)
              // runApp(MaterialApp(home: Login(currentIndex: currentIndex))),
              ),
        ],
      ),
    );
  }
}
