import 'package:bike_for_rent/models/bike_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class BikeService {
  //get trả về response code 200
  Future<List<BikeModel>> getBikeModels() async {
    Response response;
    List<BikeModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.bike));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => BikeModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeModel> getBikeById(String id) async {
    Response response;
    BikeModel result;
    try {
      response = await get(Uri.parse('${apiUrl.bike}/$id'));

      if (response.statusCode == 200) {
        result = BikeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeModel> createBike(BikeModel bikeModel) async {
    Response response;
    BikeModel result;
    try {
      response = await post(Uri.parse(apiUrl.bike),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bikeModel.toJson()));
      if (response.statusCode == 201) {
        result = BikeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeModel(String id, BikeModel bikeModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bike}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bikeModel.toJson()),
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
  Future<bool> deleteBike(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.bike}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
