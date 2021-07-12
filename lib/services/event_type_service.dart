import 'package:bike_for_rent/models/event_type_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:bike_for_rent/constants/api_url.dart' as apiUrl;

class EventTypeService {
  //get trả về response code 200
  Future<List<EventTypeModel>> getEventTypeModels() async {
    Response response;
    List<EventTypeModel> result;
    try {
      response = response = await get(Uri.parse(apiUrl.eventType));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => EventTypeModel.fromJson(item)).toList();
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //get trả về response code 200
  Future<EventTypeModel> getEventTypeById(String id) async {
    Response response;
    EventTypeModel result;
    try {
      response = await get(Uri.parse('${apiUrl.eventType}/$id'));

      if (response.statusCode == 200) {
        result = EventTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //post trả về response code 201
  Future<EventTypeModel> createEventType(EventTypeModel eventTypeModel) async {
    Response response;
    EventTypeModel result;
    try {
      response = await post(Uri.parse(apiUrl.eventType),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(eventTypeModel.toJson()));
      if (response.statusCode == 201) {
        result = EventTypeModel.fromJson(json.decode(response.body));
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }

  //put trả về response code 204
  Future<bool> updateEventTypeModel(
      String id, EventTypeModel eventTypeModel) async {
    Response response;
    bool result = false;
    try {
      response = await put(
        Uri.parse('${apiUrl.eventType}/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(eventTypeModel.toJson()),
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
  Future<bool> deleteEventType(String id) async {
    Response response;
    bool result = false;
    try {
      response = await delete(Uri.parse('${apiUrl.eventType}/$id'));
      if (response.statusCode == 204) {
        result = true;
      }
    } catch (Exception) {
      throw Exception;
    }
    return result;
  }
}
