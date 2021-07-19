import 'package:bike_for_rent/models/area_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/api.dart' as api;

class AreaService {
  //get trả về response code 200
  Future<List<AreaModel>> getAreaModels() async {
    Response response;
    List<AreaModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.area));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => AreaModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<AreaModel> getAreaById(String id) async {
    Response response;
    AreaModel result;
    try {
      response = await get(Uri.parse('${apiUrl.area}/$id'));

      if (response.statusCode == 200) {
        result = AreaModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<AreaModel> createArea(AreaModel areaModel) async {
    Response response;
    AreaModel result;
    try {
      response = await post(
        Uri.parse(apiUrl.area),
        headers: api.header,
        body: jsonEncode(areaModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = AreaModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateAreaModel(String id, AreaModel areaModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.area}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(areaModel.toJson()),
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
  Future<bool> deleteArea(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.area}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
