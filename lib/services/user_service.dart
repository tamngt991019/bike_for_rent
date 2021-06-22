import 'package:bike_for_rent/models/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class UserService {
  // List<UserModel> parseProducts(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  // }

  // Future<List<UserModel>> getUserModels() async {
  //   final response = await get(Uri.parse(apiUrl));
  //   print("Status code nè: " + response.statusCode.toString());
  //   if (response.statusCode == 200) {
  //     return parseProducts(response.body);
  //   } else {
  //     throw Exception("Lỗi mẹ rồi");
  //   }
  // }

  Future<List<UserModel>> getUserModels() async {
    Response res = await get(Uri.parse(apiUrl.user));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<UserModel> userModel =
          body.map((dynamic item) => UserModel.fromJson(item)).toList();
      return userModel;
    } else {
      throw "Failed to load UserModel list";
    }
  }

  // Future<UserModel> getUserById(String id) async {
  //   final Response response = await get('$apiUrl/$id');

  //   if (response.statusCode == 200) {
  //     return UserModel.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load a User');
  //   }
  // }

  Future<UserModel> createUser(UserModel userModel) async {
    // Map data = {
    //   "username": userModel.username,
    //   "password": userModel.password,
    //   "fullName": userModel.fullName,
    //   "email": userModel.email,
    //   "phone": userModel.phone,
    //   "avatar": userModel.avatar,
    //   "dateCreated": userModel.dateCreated,
    //   "userVerified": userModel.userVerified,
    //   "identityNo": userModel.identityNo,
    //   "frontIdentityImage": userModel.frontIdentityImage,
    //   "backIdentityImage": userModel.backIdentityImage,
    //   "ownerVerified": userModel.ownerVerified,
    //   "isRenting": userModel.isRenting,
    //   "status": userModel.status,
    // };

    try {
      final Response response = await post(Uri.parse(apiUrl.user),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userModel.toJson())
          // body: jsonEncode(<String, dynamic>{
          //   "username": userModel.username,
          //   "password": userModel.password,
          //   "fullName": userModel.fullName,
          //   "email": userModel.email,
          //   "phone": userModel.phone,
          //   "avatar": userModel.avatar,
          //   "dateCreated": userModel.dateCreated,
          //   "userVerified": userModel.userVerified,
          //   "identityNo": userModel.identityNo,
          //   "frontIdentityImage": userModel.frontIdentityImage,
          //   "backIdentityImage": userModel.backIdentityImage,
          //   "ownerVerified": userModel.ownerVerified,
          //   "isRenting": userModel.isRenting,
          //   "status": userModel.status,
          // }),

          );
      return UserModel.fromJson(json.decode(response.body));
    } catch (Exception) {
      return Exception;
    }

    // if (response.statusCode == 200) {
    //   return UserModel.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception();
    // }
  }

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
