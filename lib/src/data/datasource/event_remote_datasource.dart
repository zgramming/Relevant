import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../model/event/event_create_form_model.dart';
import '../model/event/event_detail_model.dart';
import '../model/event/event_for_you_model.dart';
import '../model/event/event_model.dart';
import '../model/event/event_nearest_date_model.dart';
import '../model/event/my_event_model.dart';
import '../model/event/response/event_join_response_model.dart';

class EventRemoteDataSource {
  Future<List<EventNearestDateModel>> nearestDate() async {
    final url = Uri.parse('$apiUrl/event/nearestDate');
    final response = await http.get(url);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      final list = decode['data'] as List;
      final events = list
          .map(
            (e) => EventNearestDateModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return events;
    } else {
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }

  Future<List<EventForYouModel>> forYou() async {
    final url = Uri.parse('$apiUrl/event/forYou');
    final response = await http.get(url);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      final list = decode['data'] as List;
      final events = list
          .map(
            (e) => EventForYouModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return events;
    } else {
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }

  Future<EventDetailModel> eventById({
    required int idEvent,
    required int idUser,
  }) async {
    final url = Uri.parse('$apiUrl/event/$idEvent/user/$idUser');
    final response = await http.get(url);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final map = decode['data'] as Map<String, dynamic>;
      final event = EventDetailModel.fromJson(map);
      return event;
    } else {
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }

  Future<List<MyEventModel>> myEvent({
    required int idUser,
    required int year,
    required int month,
  }) async {
    final url = Uri.parse('$apiUrl/event/myEvent/user/$idUser/year/$year/month/$month');
    final response = await http.get(url);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      final list = decode['data'] as List;
      final event = list
          .map(
            (e) => MyEventModel.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return event;
    } else {
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }

  ///* POST DATA

  Future<EventJoinResponseModel> joinEvent({
    required int idUser,
    required int idEvent,
  }) async {
    final url = Uri.parse('$apiUrl/eventJoined');
    final body = {
      'id_user': '$idUser',
      'id_event': '$idEvent',
    };
    final response = await http.post(url, body: body);

    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    final message = decode['message'] as String;

    if (response.statusCode == 201) {
      final event = await eventById(idEvent: idEvent, idUser: idUser);
      return EventJoinResponseModel(eventDetail: event, message: message);
    } else {
      if (decode.containsKey(VALIDATION_ERROR)) {
        final errors = decode[VALIDATION_ERROR] as Map<String, dynamic>;
        throw ValidationException(message: errors.values.join('\n'));
      }
      throw Exception(message);
    }
  }

  Future<Event> create(EventCreateFormModel form) async {
    final url = Uri.parse('$apiUrl/event');
    final request = http.MultipartRequest("POST", url)
      ..fields['id_organization'] = '${form.idOrganization}'
      ..fields['id_category'] = '${form.idCategory}'
      ..fields['title'] = form.title
      ..fields['description'] = form.description
      ..fields['start_date'] = '${form.startDate}'
      ..fields['end_date'] = '${form.endDate}'
      ..fields['type'] = eventTypeToValue[form.eventType] ?? ''
      ..fields['quota'] = '${form.quota}'
      ..fields['location'] = form.location;

    if (form.file != null) {
      /// [image] it's name in request [laravel]
      final setFile = await http.MultipartFile.fromPath('image', form.file!.path);
      request.files.add(setFile);
    }

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 201) {
      final map = decode['data'] as Map<String, dynamic>;
      final event = Event.fromJson(map);
      return event;
    } else {
      if (decode.containsKey(VALIDATION_ERROR)) {
        final errors = decode[VALIDATION_ERROR] as Map<String, dynamic>;
        throw ValidationException(message: errors.values.join('\n'));
      }
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }
}
