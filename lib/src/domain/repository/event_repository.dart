import '../../data/model/event/event_create_form_model.dart';
import '../../data/model/event/event_model.dart';

abstract class EventRepository {
  Future<Event> create(EventCreateFormModel form);
}
