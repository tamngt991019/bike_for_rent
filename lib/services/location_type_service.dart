import 'package:bike_for_rent/models/location_type_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class LocationTypeService {
  //get trả về response code 200
  Future<List<LocationTypeModel>> getLocationTypeModels(dynamic token) async {
    Response response;
    List<LocationTypeModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.locationType),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => LocationTypeModel.fromJson(item))
            .toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<LocationTypeModel> getLocationTypeById(
      String id, dynamic token) async {
    Response response;
    LocationTypeModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.locationType}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = LocationTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<LocationTypeModel> createLocationType(
      LocationTypeModel locationTypeModel, dynamic token) async {
    Response response;
    LocationTypeModel result;
    try {
      response = await post(Uri.parse(apiUrl.locationType),
          headers: configJson.headerAuth(token),
          body: jsonEncode(locationTypeModel.toJson()));
      if (response.statusCode == 201) {
        result = LocationTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateLocationTypeModel(
      String id, LocationTypeModel locationTypeModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.locationType}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(locationTypeModel.toJson()),
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
  Future<bool> deleteLocationType(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.locationType}/$id'),
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
