import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_detail_model.dart';
import '../../../domain/repository/event_repository.dart';
import '../../../utils/utils.dart';

part 'event_detail_state.dart';

class EventDetailNotifier extends StateNotifier<EventDetailState> {
  EventDetailNotifier({
    required this.repository,
  }) : super(const EventDetailState());

  final EventRepository repository;

  Future<void> get({
    required int idEvent,
    required int idUser,
  }) async {
    final result = await repository.eventById(
      idEvent: idEvent,
      idUser: idUser,
    );
    state = state.init(result);
  }

  Future<void> joinEvent({
    required int idEvent,
    required int idUser,
  }) async {
    try {
      state = state.onLoadingState(ActionType.post);
      final result = await repository.joinEvent(idUser: idUser, idEvent: idEvent);
      state = state.onSuccessJoinEvent(message: result.message, value: result.eventDetail);
    } catch (e) {
      state = state.onErrorJoinEvent((e as Failure).message);
    }
  }
}

final getEventDetail = FutureProvider.autoDispose.family<bool, int>((ref, idEvent) async {
  final user = ref.watch(userNotifier.select((value) => value.item));
  await ref.watch(eventDetailNotifier.notifier).get(
        idEvent: idEvent,
        idUser: user?.id ?? 0,
      );

  return true;
});
