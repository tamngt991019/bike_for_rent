import 'package:bike_for_rent/models/user_role_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class UserRoleService {
  //get trả về response code 200
  Future<List<UserRoleModel>> getUserRoleModels(dynamic token) async {
    Response response;
    List<UserRoleModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.userRole),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => UserRoleModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<UserRoleModel> getUserRoleById(String id, dynamic token) async {
    Response response;
    UserRoleModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.userRole}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = UserRoleModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<UserRoleModel> createUserRole(
      UserRoleModel userRoleModel, dynamic token) async {
    Response response;
    UserRoleModel result;
    try {
      response = await post(
        Uri.parse(apiUrl.userRole),
        headers: configJson.headerAuth(token),
        body: jsonEncode(userRoleModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = UserRoleModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateUserRoleModel(
      String id, UserRoleModel userRoleModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.userRole}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(userRoleModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //delete trả về response code 204
  Future<bool> deleteUserRole(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.userRole}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }
}
