import 'package:bike_for_rent/models/bike_owner_location_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class BikeOwnerLocationService {
  //get trả về response code 200
  Future<List<BikeOwnerLocationModel>> getBikeOwnerLocationModels() async {
    Response response;
    List<BikeOwnerLocationModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.bikeOwnerLocation));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => BikeOwnerLocationModel.fromJson(item))
            .toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeOwnerLocationModel> getBikeOwnerLocationById(String id) async {
    Response response;
    BikeOwnerLocationModel result;
    try {
      response = await get(Uri.parse('${apiUrl.bikeOwnerLocation}/$id'));

      if (response.statusCode == 200) {
        result = BikeOwnerLocationModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeOwnerLocationModel> createBikeOwnerLocation(
      BikeOwnerLocationModel bikeOwnerLocationModel) async {
    Response response;
    BikeOwnerLocationModel result;
    try {
      response = await post(Uri.parse(apiUrl.bikeOwnerLocation),
          headers: <String, String>{
            'Content-OwnerLocation': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bikeOwnerLocationModel.toJson()));
      if (response.statusCode == 201) {
        result = BikeOwnerLocationModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeOwnerLocationModel(
      String id, BikeOwnerLocationModel bikeOwnerLocationModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bikeOwnerLocation}/$id'),
        headers: <String, String>{
          'Content-OwnerLocation': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bikeOwnerLocationModel.toJson()),
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
  Future<bool> deleteBikeOwnerLocation(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.bikeOwnerLocation}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
