import 'package:bike_for_rent/models/user_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class UserService {
  //get trả về response code 200
  Future<List<UserModel>> getUserModels() async {
    Response response;
    List<UserModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.user));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<UserModel> getUserById(String id) async {
    Response response;
    UserModel result;
    try {
      response = await get(Uri.parse('${apiUrl.user}/$id'));

      if (response.statusCode == 200) {
        result = UserModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<UserModel> createUser(UserModel userModel) async {
    Response response;
    UserModel result;
    try {
      response = await post(Uri.parse(apiUrl.user),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userModel.toJson()));
      if (response.statusCode == 201) {
        result = UserModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateUserModel(String id, UserModel userModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.user}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //delete trả về response code 204
  Future<bool> deleteUser(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.user}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
