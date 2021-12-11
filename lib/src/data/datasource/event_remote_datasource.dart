import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../model/event/event_create_form_model.dart';
import '../model/event/event_for_you_model.dart';
import '../model/event/event_model.dart';
import '../model/event/event_nearest_date_model.dart';

class EventRemoteDataSource {
  // Future<List<Event>> get() async {}
  Future<Event> create(EventCreateFormModel form) async {
    final url = Uri.parse('$apiUrl/event');
    final body = {
      'id_organization': '${form.idOrganization}',
      'id_category': '${form.idCategory}',
      'title': form.title,
      'description': form.description,
      'start_date': "${form.startDate}",
      'end_date': "${form.endDate}",
      'type': eventTypeToValue[form.eventType],
      'quota': '${form.quota}',
      'location': form.location,
      if (form.file != null) 'image': '${form.file}'
    };

    // log('body $body');
    final response = await http.post(url, body: body);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201) {
      final map = decode['data'] as Map<String, dynamic>;
      log('map ${DateTime.parse(map['end_date'] as String)}');
      // throw Exception('ts');
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
}
