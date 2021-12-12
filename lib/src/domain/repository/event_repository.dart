import '../../data/model/event/event_create_form_model.dart';
import '../../data/model/event/event_detail_model.dart';
import '../../data/model/event/event_for_you_model.dart';
import '../../data/model/event/event_model.dart';
import '../../data/model/event/event_nearest_date_model.dart';
import '../../data/model/event/response/event_join_response_model.dart';

abstract class EventRepository {
  Future<Event> create(EventCreateFormModel form);
  Future<List<EventNearestDateModel>> nearestDate();
  Future<List<EventForYouModel>> forYou();
  Future<EventDetailModel> eventById({
    required int idEvent,
    required int idUser,
  });

  Future<EventJoinResponseModel> joinEvent({
    required int idUser,
    required int idEvent,
  });
}
