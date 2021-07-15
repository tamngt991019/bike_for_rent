import 'package:bike_for_rent/models/booking_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class BookingService {
  //get trả về response code 200
  Future<List<BookingModel>> getBookingModels() async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.booking));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<BookingModel> getBookingById(String id) async {
    Response response;
    BookingModel result;
    try {
      response = await get(Uri.parse('${apiUrl.booking}/$id'));

      if (response.statusCode == 200) {
        result = BookingModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<List<BookingModel>> getCustomerWithBookingProcessing(
      String username) async {
    Response response;
    List<BookingModel> result;
    try {
      response = await get(Uri.parse(
          '${apiUrl.booking}/customer/processing?username=$username'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<List<BookingModel>> getCustomerBookingsTracking(
      String username) async {
    Response response;
    List<BookingModel> result;
    try {
      response = await get(
          Uri.parse('${apiUrl.booking}/customer/tracking?username=$username'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //customer history
  Future<List<BookingModel>> getListCustomerBookingFinishedCanceled(
      String username) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
          Uri.parse('${apiUrl.booking}/customer/bike/fc?username=$username'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  Future<List<BookingModel>> getListBookingByBikeIdWithRating(
      String bikeId) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response =
          await get(Uri.parse('${apiUrl.booking}/bike/rating?bikeId=$bikeId'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  Future<List<BookingModel>> getListOwnerBookingWithRating(
      String username) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
          Uri.parse('${apiUrl.booking}/owner/rating?username=$username'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<BookingModel> createBooking(BookingModel bookingModel) async {
    Response response;
    BookingModel result;
    try {
      response = await post(Uri.parse(apiUrl.booking),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(bookingModel.toJson()));
      if (response.statusCode == 201) {
        result = BookingModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBookingModel(String id, BookingModel bookingModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.booking}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bookingModel.toJson()),
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
  Future<bool> deleteBooking(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.booking}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  // get trả về response code 200
  Future<bool> isExistCustomerTrackingBooking(String username) async {
    Response response;
    bool result = false;
    try {
      response = await get(Uri.parse(
          '${apiUrl.booking}/customer/check/tracking?username=$username'));
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
