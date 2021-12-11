import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_detail_model.dart';
import '../../../domain/repository/event_repository.dart';

part 'event_detail_state.dart';

class EventDetailNotifier extends StateNotifier<EventDetailState> {
  EventDetailNotifier({
    required this.repository,
  }) : super(const EventDetailState());

  final EventRepository repository;

  Future<void> get(int idEvent) async {
    final result = await repository.eventById(idEvent);
    state = state.init(result);
  }
}

final getEventDetail = AutoDisposeFutureProviderFamily<bool, int>((ref, idEvent) async {
  await ref.watch(eventDetailNotifier.notifier).get(idEvent);
  return true;
});
