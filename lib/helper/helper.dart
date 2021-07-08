import 'package:bike_for_rent/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/status.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;
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

//Tinh khoang cach
double calculatekDistance(
    LatLng _currentLatLing, double checkLati, double checkLong) {
  var y = 40000 / 360;
  var x = math.cos(math.pi * _currentLatLing.latitude / 180.0) * y;
  var dx = ((_currentLatLing.longitude - checkLong) * x).abs(); //dimension x
  var dy = ((_currentLatLing.latitude - checkLati) * y).abs(); //dimension y
  double result = math.sqrt(dx * dx + dy * dy);
  return result;
}

// lay cac toa do trong ban kinh 5k
List<LocationModel> getLocationsByRadius(
    LatLng _currentLatLing, List<LocationModel> listLoc, double radius) {
  List<LocationModel> result = [];
  for (var loc in listLoc) {
    double checkLati = double.parse(loc.latitude);
    double checkLong = double.parse(loc.longitude);
    double distance = calculatekDistance(_currentLatLing, checkLati, checkLong);
    if (distance <= radius) {
      result.add(loc);
    }
  }
  return result;
}

// convert status code
String getStatus(String statusStr) {
  String result = "";
  if (statusStr == "FINISHED") {
    result = stt.FINISHED;
  } else if (statusStr == "CANCELED") {
    result = stt.CANCELED;
  }
  return result;
}

// chuyen huong man hinh
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
