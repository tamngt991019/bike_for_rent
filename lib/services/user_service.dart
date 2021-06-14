import 'package:bike_for_rent/models/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class UserService {
  final String apiUrl = 'https://localhost:44374/api/users';

  List<UserModel> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  }

  Future<List<UserModel>> getUserModels() async {
    final response = await get('https://localhost:44374/api/users');
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Future<List<UserModel>> getUserModels() async {
  //   Response res = await get(apiUrl);

  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);
  //     List<UserModel> userModel =
  //         body.map((dynamic item) => UserModel.fromJson(item)).toList();
  //     return userModel;
  //   } else {
  //     throw "Failed to load UserModel list";
  //   }
  // }

  // Future<UserModel> getUserById(String id) async {
  //   final Response response = await get('$apiUrl/$id');

  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load a User');
  //   }
  // }

  // Future<UserModel> createUser(UserModel userModel) async {
  //   final Response response = await post(
  //     apiUrl,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(userModel.toJson()),
  //   );
  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to post UserModel');
  //   }
  // }

  // Future<UserModel> updateUserModel(String id, UserModel userModel) async {
  //   final Response response = await put(
  //     '$apiUrl/$id',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(userModel.toJson()),
  //   );
  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to update a User');
  //   }
  // }

  // Future<void> deleteUser(String id) async {
  //   Response res = await delete('$apiUrl/$id');

  //   if (res.statusCode == 200) {
  //     print("User deleted");
  //   } else {
  //     throw "Failed to delete a User.";
  //   }
  // }
}
