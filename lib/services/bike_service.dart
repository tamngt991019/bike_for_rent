import 'package:bike_for_rent/models/bike_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class BikeService {
  //get trả về response code 200
  Future<List<BikeModel>> getBikeModels(dynamic token) async {
    Response response;
    List<BikeModel> result;
    try {
      response = await get(
        Uri.parse(apiUrl.bike),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => BikeModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<List<BikeModel>> getBikesWithLocationDistance(
    String username,
    String bikeTypeId,
    double currentlati,
    double currentLong,
    double radius,
    dynamic token,
  ) async {
    Response response;
    List<BikeModel> result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.bike}/lat/lng/radius?username=$username&bikeTypeId=$bikeTypeId&currentLati=$currentlati&currentLong=$currentLong&radius=$radius'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => BikeModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeModel> getBikeById(String id, dynamic token) async {
    Response response;
    BikeModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bike}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BikeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeModel> getBikeByIdWithTypeBrandImages(
      String id, dynamic token) async {
    Response response;
    BikeModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bike}/type/brand/iamges?id=$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BikeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  Future<BikeModel> getBikeByIdWithTypeBrandImagesUser(
      String id, dynamic token) async {
    Response response;
    BikeModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bike}/type/brand/iamges/user?id=$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BikeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeModel> createBike(BikeModel bikeModel, dynamic token) async {
    Response response;
    BikeModel result;
    try {
      response = await post(
        Uri.parse(apiUrl.bike),
        headers: configJson.headerAuth(token),
        body: jsonEncode(bikeModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = BikeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeModel(
      String id, BikeModel bikeModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bike}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(bikeModel.toJson()),
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
  Future<bool> deleteBike(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.bike}/$id'),
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
