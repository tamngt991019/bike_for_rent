import 'package:bike_for_rent/models/pay_package_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class PayPackageService {
  //get trả về response code 200
  Future<List<PayPackageModel>> getPayPackageModels(dynamic token) async {
    Response response;
    List<PayPackageModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.payPackage),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => PayPackageModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<List<PayPackageModel>> getPayPackageModelsByBikeType(
      String bikeTypeId, dynamic token) async {
    Response response;
    List<PayPackageModel> result;
    try {
      response = response = await get(
        Uri.parse('${apiUrl.payPackage}/bikeTypeId?bikeTypeId=$bikeTypeId'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => PayPackageModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<PayPackageModel> getPayPackageById(String id, dynamic token) async {
    Response response;
    PayPackageModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.payPackage}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = PayPackageModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<PayPackageModel> createPayPackage(
      PayPackageModel payPackageModel, dynamic token) async {
    Response response;
    PayPackageModel result;
    try {
      response = await post(Uri.parse(apiUrl.payPackage),
          headers: configJson.headerAuth(token),
          body: jsonEncode(payPackageModel.toJson()));
      if (response.statusCode == 201) {
        result = PayPackageModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updatePayPackageModel(
      String id, PayPackageModel payPackageModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.payPackage}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(payPackageModel.toJson()),
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
  Future<bool> deletePayPackage(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.payPackage}/$id'),
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
