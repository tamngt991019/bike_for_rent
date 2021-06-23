import 'package:bike_for_rent/models/user_role_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class UserRoleService {
  //get trả về response code 200
  Future<List<UserRoleModel>> getUserRoleModels() async {
    Response response;
    List<UserRoleModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.userRole));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => UserRoleModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<UserRoleModel> getUserRoleById(String id) async {
    Response response;
    UserRoleModel result;
    try {
      response = await get(Uri.parse('${apiUrl.userRole}/$id'));

      if (response.statusCode == 200) {
        result = UserRoleModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<UserRoleModel> createUserRole(UserRoleModel userRoleModel) async {
    Response response;
    UserRoleModel result;
    try {
      response = await post(Uri.parse(apiUrl.userRole),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userRoleModel.toJson()));
      if (response.statusCode == 201) {
        result = UserRoleModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateUserRoleModel(
      String id, UserRoleModel userRoleModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.userRole}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userRoleModel.toJson()),
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
  Future<bool> deleteUserRole(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.userRole}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
