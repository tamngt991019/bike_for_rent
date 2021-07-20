import 'package:bike_for_rent/models/bike_brand_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class BikeBrandService {
  //get trả về response code 200
  Future<List<BikeBrandModel>> getBikeBrandModels() async {
    Response response;
    List<BikeBrandModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.bikeBrand),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BikeBrandModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BikeBrandModel> getBikeBrandById(String id) async {
    Response response;
    BikeBrandModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bikeBrand}/$id'),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        result = BikeBrandModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<BikeBrandModel> createBikeBrand(BikeBrandModel bikeBrandModel) async {
    Response response;
    BikeBrandModel result;
    try {
      response = await post(
        Uri.parse(apiUrl.bikeBrand),
        headers: configJson.header(),
        body: jsonEncode(bikeBrandModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = BikeBrandModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBikeBrandModel(
      String id, BikeBrandModel bikeBrandModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bikeBrand}/$id'),
        headers: configJson.header(),
        body: jsonEncode(bikeBrandModel.toJson()),
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
  Future<bool> deleteBikeBrand(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.bikeBrand}/$id'),
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
