import 'package:bike_for_rent/models/bike_image_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class BikeImageService {
  //get trả về response code 200
  Future<List<BikeImageModel>> getBikeImageModels() async {
    Response response;
    List<BikeImageModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.bikeImage));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BikeImageModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeImageModel> getBikeImageById(String id) async {
    Response response;
    BikeImageModel result;
    try {
      response = await get(Uri.parse('${apiUrl.bikeImage}/$id'));

      if (response.statusCode == 200) {
        result = BikeImageModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeImageModel> createBikeImage(BikeImageModel bikeImageModel) async {
    Response response;
    BikeImageModel result;
    try {
      response = await post(Uri.parse(apiUrl.bikeImage),
          headers: <String, String>{
            'Content-Image': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bikeImageModel.toJson()));
      if (response.statusCode == 201) {
        result = BikeImageModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeImageModel(
      String id, BikeImageModel bikeImageModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bikeImage}/$id'),
        headers: <String, String>{
          'Content-Image': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bikeImageModel.toJson()),
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
  Future<bool> deleteBikeImage(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.bikeImage}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
