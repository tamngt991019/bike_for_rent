import 'dart:io';

import 'package:bike_for_rent/pages/home.dart';
import 'package:bike_for_rent/pages/rating.dart';
import 'package:bike_for_rent/pages/register.dart';
import 'package:flutter/material.dart';

void main() {
  // HttpOverrides.global = new MyHttpOverrides();
  runApp(MaterialApp(home: Rating()));
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) = true;
//   }
// }
