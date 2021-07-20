import 'package:bike_for_rent/models/bike_type_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class BikeTypeService {
  //get trả về response code 200
  Future<List<BikeTypeModel>> getBikeTypeModels() async {
    Response response;
    List<BikeTypeModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.bikeType),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BikeTypeModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeTypeModel> getBikeTypeById(String id) async {
    Response response;
    BikeTypeModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bikeType}/$id'),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        result = BikeTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeTypeModel> createBikeType(BikeTypeModel bikeTypeModel) async {
    Response response;
    BikeTypeModel result;
    try {
      response = await post(Uri.parse(apiUrl.bikeType),
          headers: configJson.header(),
          body: jsonEncode(bikeTypeModel.toJson()));
      if (response.statusCode == 201) {
        result = BikeTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeTypeModel(
      String id, BikeTypeModel bikeTypeModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bikeType}/$id'),
        headers: configJson.header(),
        body: jsonEncode(bikeTypeModel.toJson()),
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
  Future<bool> deleteBikeType(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.bikeType}/$id'),
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
