import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/event_type_id.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

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
bool isEmptyText(String value) {
  if (value.isEmpty) {
    return true;
  } else {
    return false;
  }
}

//tinh gio tinh tien

double daysElapsedSince(DateTime from, DateTime to) {
// get the difference in term of days, and not just a 24h difference
  from = DateTime(from.year, from.month, from.day, from.hour);
  to = DateTime(to.year, to.month, to.day, from.hour);
  return (to.difference(from).inMinutes / 1440).toDouble();
}

double priceTotal(double time, PayPackageModel payPackageModel) {
  if (time * 24 < payPackageModel.hours) {
    return payPackageModel.price.toDouble();
  }
  if (time * 24 > payPackageModel.hours) {
    if (payPackageModel.id.toLowerCase().contains("xs")) {
      if (((time * 1440) % 60) > 0) {
        return (payPackageModel.price +
                (time * 24 + 1 - payPackageModel.hours) * 5000)
            .toDouble();
      } else
        return (payPackageModel.price +
                (time * 24 - payPackageModel.hours) * 5000)
            .toDouble();
    }
    if (payPackageModel.id.toLowerCase().contains("xtg")) {
      if (((time * 1440) % 60) > 0) {
        return (payPackageModel.price +
                (time * 24 + 1 - payPackageModel.hours) * 6000)
            .toDouble();
      } else
        return (payPackageModel.price +
                (time * 24 - payPackageModel.hours) * 6000)
            .toDouble();
    }
  }
  return payPackageModel.price.toDouble();
}
