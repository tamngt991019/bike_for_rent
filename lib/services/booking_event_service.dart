import 'package:bike_for_rent/models/booking_event_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class BookingEventService {
  //get trả về response code 200
  Future<List<BookingEventModel>> getBookingEventModels(dynamic token) async {
    Response response;
    List<BookingEventModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.bookingEvent),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => BookingEventModel.fromJson(item))
            .toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BookingEventModel> getBookingEventById(
      String id, dynamic token) async {
    Response response;
    BookingEventModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.bookingEvent}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BookingEventModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<BookingEventModel> createBookingEvent(
      BookingEventModel bookingEventModel, dynamic token) async {
    Response response;
    BookingEventModel result;
    try {
      response = await post(Uri.parse(apiUrl.bookingEvent),
          headers: configJson.headerAuth(token),
          body: jsonEncode(bookingEventModel.toJson()));
      if (response.statusCode == 201) {
        result = BookingEventModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBookingEventModel(
      String id, BookingEventModel bookingEventModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.bookingEvent}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(bookingEventModel.toJson()),
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
  Future<bool> deleteBookingEvent(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.bookingEvent}/$id'),
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
