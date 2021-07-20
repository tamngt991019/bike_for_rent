import 'package:bike_for_rent/models/booking_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;
import 'package:bike_for_rent/constants/config_json.dart' as configJson;

class BookingService {
  //get trả về response code 200
  Future<List<BookingModel>> getBookingModels(dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse(apiUrl.booking),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BookingModel> getBookingById(String id, dynamic token) async {
    Response response;
    BookingModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.booking}/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BookingModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<BookingModel> getTrackingBookingById(String id, dynamic token) async {
    Response response;
    BookingModel result;
    try {
      response = await get(
        Uri.parse('${apiUrl.booking}/tracking/detail/$id'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        result = BookingModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<List<BookingModel>> getCustomerWithBookingProcessing(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = await get(
        Uri.parse('${apiUrl.booking}/customer/processing?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<List<BookingModel>> getCustomerBookingsTracking(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = await get(
        Uri.parse('${apiUrl.booking}/customer/tracking?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //get trả về response code 200
  Future<List<BookingModel>> getOwnerBookingsTracking(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = await get(
        Uri.parse('${apiUrl.booking}/owner/tracking?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //customer history
  Future<List<BookingModel>> getListCustomerBookingWithBikeFinishedCanceled(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse('${apiUrl.booking}/customer/bike/fc?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //owner history
  Future<List<BookingModel>> ownerBookingHistoryList(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse('${apiUrl.booking}/owner/manager/history?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //owner processing
  Future<List<BookingModel>> ownerBookingProcessingList(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse(
            '${apiUrl.booking}/owner/manager/processing?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //owner are renting
  Future<List<BookingModel>> ownerBookingAreRentingList(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse(
            '${apiUrl.booking}/owner/manager/arerenting?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  Future<List<BookingModel>> getListBookingByBikeIdWithRating(
      String bikeId, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse('${apiUrl.booking}/bike/rating?bikeId=$bikeId'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  Future<List<BookingModel>> getListOwnerBookingWithRating(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse('${apiUrl.booking}/owner/rating?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  Future<List<BookingModel>> getListOwnerBookingProcessing(
      String username, dynamic token) async {
    Response response;
    List<BookingModel> result;
    try {
      response = response = await get(
        Uri.parse('${apiUrl.booking}/owner/processing?username=$username'),
        headers: configJson.headerAuth(token),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => BookingModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //post trả về response code 201
  Future<BookingModel> createBooking(
      BookingModel bookingModel, dynamic token) async {
    Response response;
    BookingModel result;
    try {
      response = await post(Uri.parse(apiUrl.booking),
          headers: configJson.headerAuth(token),
          body: jsonEncode(bookingModel.toJson()));
      if (response.statusCode == 201) {
        result = BookingModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateBookingModel(
      String id, BookingModel bookingModel, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.booking}/$id'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(bookingModel.toJson()),
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
  Future<bool> deleteBooking(String id, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await delete(
        Uri.parse('${apiUrl.booking}/$id'),
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

  // get trả về response code 200
  Future<bool> isExistCustomerTrackingBooking(
      String username, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.booking}/customer/check/tracking?username=$username'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }

  // get trả về response code 200
  Future<bool> isExistOwnerTrackingBooking(
      String username, dynamic token) async {
    Response response;
    bool result = false;
    try {
      response = await get(
        Uri.parse('${apiUrl.booking}/owner/check/tracking?username=$username'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
      // print(Exception);
    }
    return result;
  }
}
