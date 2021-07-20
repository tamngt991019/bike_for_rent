import 'package:bike_for_rent/models/user_model.dart';

Map<String, String> headerAuth(UserModel userModel) {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'bearer ' + userModel.token,
  };
}

Map<String, String> header() {
  return {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
