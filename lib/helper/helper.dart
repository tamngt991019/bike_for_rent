// animation chuyen trang
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/status.dart' as stt;
// Route route(Widget wg, bool isRightToLeft) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => wg,
//     transitionDuration: Duration(milliseconds: 750),
//     transitionsBuilder: (BuildContext context, Animation<double> animation,
//         Animation<double> secondaryAnimation, Widget child) {
//       var begin = (isRightToLeft == true) ? Offset(200, 0) : Offset(-200, 0);
//       var end = Offset.zero;
//       var curve = Curves.easeInOut;
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//       // return FadeTransition(
//       //   opacity: animation,
//       //   child: child,
//       // );
//     },
//   );
// }

String getStatus(String statusStr) {
  String result = "";
  if (statusStr == "FINISHED") {
    result = stt.FINISHED;
  } else if (statusStr == "CANCELED") {
    result = stt.CANCELED;
  }
  return result;
}

Text getBookingStatus(String statusStr) {
  String resultStr = getStatus(statusStr);
  Color txtColor;
  return Text(
    resultStr,
    style: TextStyle(
      fontSize: 15,
      color: txtColor,
    ),
  );
}

void pushInto(BuildContext context, Widget wg, bool isRightToLeft) {
  Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => wg,
        transitionDuration: Duration(milliseconds: 750),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          var begin = (isRightToLeft == true) ? Offset(50, 0) : Offset(-50, 0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
          // return FadeTransition(
          //   opacity: animation,
          //   child: child,
          // );
        },
      ),
      (route) => false);
}

// kiem tra fill trong
bool checkEmptyText(String value) {
  if (value.isEmpty) {
    return true;
  } else {
    return false;
  }
}
