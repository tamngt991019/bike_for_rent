import 'package:bike_for_rent/models/bike_image_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class BikeImageService {
  //get trả về response code 200
  Future<List<BikeImageModel>> getBikeImageModels(dynamic token) async {
    Response response;
    List<BikeImageModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.bikeImage),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BikeImageModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeImageModel> getBikeImageById(String id, dynamic token) async {
    Response response;
    BikeImageModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bikeImage}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BikeImageModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeImageModel> createBikeImage(
      BikeImageModel bikeImageModel, dynamic token) async {
    Response response;
    BikeImageModel result;
    try {
      response = await post(Uri.parse(apiUrl.bikeImage),
          headers: configJson.headerAuth(token),
          body: jsonEncode(bikeImageModel.toJson()));
      if (response.statusCode == 201) {
        result = BikeImageModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeImageModel(
      String id, BikeImageModel bikeImageModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bikeImage}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(bikeImageModel.toJson()),
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
  Future<bool> deleteBikeImage(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.bikeImage}/$id'),
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
