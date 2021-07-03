// animation chuyen trang
import 'package:flutter/material.dart';

Route route(Widget wg, bool isRightToLeft) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => wg,
    transitionDuration: Duration(milliseconds: 750),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      var begin = (isRightToLeft == true) ? Offset(200, 0) : Offset(-200, 0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
      // return FadeTransition(
      //   opacity: animation,
      //   child: child,
      // );
    },
  );
}

// kiem tra fill trong
bool checkEmptyText(String value) {
  if (value.isEmpty) {
    return true;
  } else {
    return false;
  }
}
