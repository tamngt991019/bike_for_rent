import 'package:bike_for_rent/models/location_type_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class LocationTypeService {
  //get trả về response code 200
  Future<List<LocationTypeModel>> getLocationTypeModels() async {
    Response response;
    List<LocationTypeModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.locationType));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => LocationTypeModel.fromJson(item))
            .toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<LocationTypeModel> getLocationTypeById(String id) async {
    Response response;
    LocationTypeModel result;
    try {
      response = await get(Uri.parse('${apiUrl.locationType}/$id'));

      if (response.statusCode == 200) {
        result = LocationTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<LocationTypeModel> createLocationType(
      LocationTypeModel locationTypeModel) async {
    Response response;
    LocationTypeModel result;
    try {
      response = await post(Uri.parse(apiUrl.locationType),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(locationTypeModel.toJson()));
      if (response.statusCode == 201) {
        result = LocationTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateLocationTypeModel(
      String id, LocationTypeModel locationTypeModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.locationType}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(locationTypeModel.toJson()),
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
  Future<bool> deleteLocationType(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.locationType}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
