import 'package:bike_for_rent/models/role_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class RoleService {
  //get trả về response code 200
  Future<List<RoleModel>> getRoleModels() async {
    Response response;
    List<RoleModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.role),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => RoleModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<RoleModel> getRoleById(String id) async {
    Response response;
    RoleModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.role}/$id'),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        result = RoleModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<RoleModel> createRole(RoleModel roleModel) async {
    Response response;
    RoleModel result;
    try {
      response = await post(
        Uri.parse(apiUrl.role),
        headers: configJson.header(),
        body: jsonEncode(roleModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = RoleModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateRoleModel(String id, RoleModel roleModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.role}/$id'),
        headers: configJson.header(),
        body: jsonEncode(roleModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //delete trả về response code 204
  Future<bool> deleteRole(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.role}/$id'),
        headers: configJson.header(),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }
}
