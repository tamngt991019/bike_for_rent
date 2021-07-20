import 'package:bike_for_rent/models/payment_type_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class PaymentTypeService {
  //get trả về response code 200
  Future<List<PaymentTypeModel>> getPaymentTypeModels() async {
    Response response;
    List<PaymentTypeModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.paymentType),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => PaymentTypeModel.fromJson(item))
            .toList();
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<PaymentTypeModel> getPaymentTypeById(String id) async {
    Response response;
    PaymentTypeModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.paymentType}/$id'),
        headers: configJson.header(),
      );

      if (response.statusCode == 200) {
        result = PaymentTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<PaymentTypeModel> createPaymentType(
      PaymentTypeModel paymentTypeModel) async {
    Response response;
    PaymentTypeModel result;
    try {
      response = await post(Uri.parse(apiUrl.paymentType),
          headers: configJson.header(),
          body: jsonEncode(paymentTypeModel.toJson()));
      if (response.statusCode == 201) {
        result = PaymentTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      // throw Exception;
      print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updatePaymentTypeModel(
      String id, PaymentTypeModel paymentTypeModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.paymentType}/$id'),
        headers: configJson.header(),
        body: jsonEncode(paymentTypeModel.toJson()),
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
  Future<bool> deletePaymentType(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.paymentType}/$id'),
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
