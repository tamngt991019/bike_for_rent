import 'package:bike_for_rent/models/location_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class LocationService {
  //get trả về response code 200
  Future<List<LocationModel>> getLocationModels(dynamic token) async {
    Response response;
    List<LocationModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.location),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => LocationModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<List<LocationModel>> getLocationsWithLatLngAndDistacne(
      double currentlati,
      double currentLong,
      double radius,
      dynamic token) async {
    Response response;
    List<LocationModel> result;
    try {
      response = response = await get(
        Uri.parse(
            '${apiUrl.location}/lat/lng/radius?currentLati=$currentlati&currentLong=$currentLong&radius=$radius'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => LocationModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<LocationModel> getLocationById(String id, dynamic token) async {
    Response response;
    LocationModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.location}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = LocationModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<LocationModel> createLocation(
      LocationModel locationModel, dynamic token) async {
    Response response;
    LocationModel result;
    try {
      response = await post(Uri.parse(apiUrl.location),
          headers: configJson.headerAuth(token),
          body: jsonEncode(locationModel.toJson()));
      if (response.statusCode == 201) {
        result = LocationModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateLocationModel(
      String id, LocationModel locationModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.location}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(locationModel.toJson()),
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
  Future<bool> deleteLocation(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.location}/$id'),
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
