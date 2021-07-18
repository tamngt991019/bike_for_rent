import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:flutter/material.dart';
import 'package:bike_for_rent/constants/event_type_id.dart' as stt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

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

// lay cac toa do trong ban kinh s
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
// double.parse((result / list.length).toStringAsFixed(1));
// double daysElapsedSince(DateTime from, DateTime to) {
// // get the difference in term of days, and not just a 24h difference
//   from = DateTime(from.year, from.month, from.day, from.hour);
//   to = DateTime(to.year, to.month, to.day, from.hour);
//   String days = (to.difference(from).inMinutes / 1440).toString();
//   String hours = (to.difference(from).inMinutes / 1440).toString();
//   return to.difference(from).inSeconds.toDouble();
//   // return (days + " ngày " + hours + " giờ ");
// }

// String dayElapsed(DateTime from, DateTime to) {
//   from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
//   to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
//   int difference = to.difference(from).inMinutes;
//   if (difference % 1440 > 0) {
//     return (difference ~/ 1440).toString() +
//         " ngày " +
//         (((difference % 1440) ~/ 60) + 1).toString() +
//         " giờ ";
//   }
//   return (difference ~/ 1440).toString() +
//       " ngày " +
//       (difference % 60).toString() +
//       " giờ ";
// }

String getDateFormatStr(String dateStr) {
  return DateFormat('dd/MM/yyyy – kk:mm:ss').format(DateTime.parse(dateStr));
}

String getDayElapsed(String dateFrom, String dateTo) {
  DateTime from = DateTime.parse(dateFrom);
  DateTime to = DateTime.parse(dateTo);
  from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
  int difference = to.difference(from).inHours;
  String result = "";
  if ((difference ~/ 24) > 0) {
    result += (difference ~/ 24).toString() + " ngày ";
  }
  if (difference % 60 >= 0) {
    result += ((difference % 24) + 1).toString() + " giờ ";
    // return (difference ~/ 24).toString() +
    //     " ngày " +
    //     ((difference % 24) + 1).toString() +
    //     " giờ ";
  } else {
    result += (difference % 24).toString() + " giờ ";
  }
  // return (difference ~/ 24).toString() +
  //     " ngày " +
  //     (difference % 24).toString() +
  //     " giờ ";
  return result;
}

double getTotalHours(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
  int difference = to.difference(from).inHours;
  if (difference % 60 > 0) {
    return (difference % 60).toDouble() + 1;
  }
  return (difference % 60).toDouble();
}

String getPriceTotalStr(String dateFrom, String dateTo, String bikeTypeId,
    PayPackageModel payPackageModel) {
  DateTime from = DateTime.parse(dateFrom);
  DateTime to = DateTime.parse(dateTo);
  double totalHours = getTotalHours(from, to);

  double price = double.parse(payPackageModel.price.toString());
  double hours = double.parse(payPackageModel.hours.toString());
  if (totalHours <= hours) {
    return price.toString();
  }
  double hoursRemaining = totalHours - hours;
  double result = 0;
  if (bikeTypeId.toLowerCase() == "xs".toLowerCase()) {
    result = price + hoursRemaining * 5000;
  } else if (bikeTypeId.toLowerCase() == "xtg".toLowerCase()) {
    result = price + hoursRemaining * 6000;
  }
  return result.toString();
}

// String getTotalPriceStr(String dateFrom, String dateTo) {
//   String result;
//   DateTime from = DateTime.parse(dateFrom);
//   DateTime to = DateTime.parse(dateTo);
//   double hours = getTotalHours(from, to);
//   double price = getPriceTotal(hours, mainBooking.payPackageModel);
//   return price.toString();
// }

// if (time * 24 < payPackageModel.hours) {
//   return payPackageModel.price.toDouble();
// }
// if (time * 24 > payPackageModel.hours) {
//   if (payPackageModel.id.toLowerCase().contains("xs")) {
//     if (((time * 1440) % 60) > 0) {
//       return (payPackageModel.price +
//               (time * 24 + 1 - payPackageModel.hours) * 5000)
//           .toDouble();
//     } else
//       return (payPackageModel.price +
//               (time * 24 - payPackageModel.hours) * 5000)
//           .toDouble();
//   }
//   if (payPackageModel.id.toLowerCase().contains("xtg")) {
//     if (((time * 1440) % 60) > 0) {
//       return (payPackageModel.price +
//               (time * 24 + 1 - payPackageModel.hours) * 6000)
//           .toDouble();
//     } else
//       return (payPackageModel.price +
//               (time * 24 - payPackageModel.hours) * 6000)
//           .toDouble();
//   }
// }
// return payPackageModel.price.toDouble();
