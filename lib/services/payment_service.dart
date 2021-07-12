import 'package:bike_for_rent/models/payment_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class PaymentService {
  //get trả về response code 200
  Future<List<PaymentModel>> getPaymentModels() async {
    Response response;
    List<PaymentModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.payment));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => PaymentModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<PaymentModel> getPaymentById(String id) async {
    Response response;
    PaymentModel result;
    try {
      response = await get(Uri.parse('${apiUrl.payment}/$id'));

      if (response.statusCode == 200) {
        result = PaymentModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<PaymentModel> createPayment(PaymentModel paymentModel) async {
    Response response;
    PaymentModel result;
    try {
      response = await post(Uri.parse(apiUrl.payment),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(paymentModel.toJson()));
      if (response.statusCode == 201) {
        result = PaymentModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updatePaymentModel(String id, PaymentModel paymentModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.payment}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(paymentModel.toJson()),
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
  Future<bool> deletePayment(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.payment}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
