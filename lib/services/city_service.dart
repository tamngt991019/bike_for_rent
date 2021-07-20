import 'package:bike_for_rent/models/city_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class CityService {
  //get trả về response code 200
  Future<List<CityModel>> getCityModels() async {
    Response response;
    List<CityModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.city),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => CityModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<CityModel> getCityById(String id) async {
    Response response;
    CityModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.city}/$id'),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        result = CityModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<CityModel> createCity(CityModel cityModel) async {
    Response response;
    CityModel result;
    try {
      response = await post(
        Uri.parse(apiUrl.city),
        headers: configJson.header(),
        body: jsonEncode(cityModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = CityModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateCityModel(String id, CityModel cityModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.city}/$id'),
        headers: configJson.header(),
        body: jsonEncode(cityModel.toJson()),
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
  Future<bool> deleteCity(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.city}/$id'),
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
