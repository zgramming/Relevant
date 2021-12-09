import 'package:dartz/dartz.dart';
import '../../data/model/event/event_create_form_model.dart';
import '../../data/model/event/event_model.dart';
import '../../utils/utils.dart';

abstract class EventRepository {
  Future<Either<Failure, Event>> create(EventCreateFormModel form);
}
