import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/event/event_create_form_model.dart';
import '../../../data/model/event/event_model.dart';
import '../../../domain/repository/event_repository.dart';
import '../../../utils/utils.dart';

part 'event_state.dart';

class EventNotifier extends StateNotifier<EventState> {
  EventNotifier({
    required this.repository,
  }) : super(const EventState());
  final EventRepository repository;

  Future<void> create(EventCreateFormModel form) async {
    try {
      state = state.onLoadingState(ActionType.post);
      final result = await repository.create(form);
      state = state.onSuccessCreateEvent(result);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorState(failure.message);
    }
  }
}
