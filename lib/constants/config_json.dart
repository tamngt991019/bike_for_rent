import 'package:bike_for_rent/models/user_model.dart';

Map<String, String> headerAuth(dynamic token) {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + token.toString(),
  };
}

Map<String, String> header() {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
