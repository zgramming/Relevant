import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_nearest_date_model.dart';
import '../../../domain/repository/event_repository.dart';

part 'event_nearest_date_state.dart';

class EventNearestDateNotifier extends StateNotifier<EventNearestDateState> {
  EventNearestDateNotifier({
    required this.repository,
  }) : super(const EventNearestDateState());

  final EventRepository repository;

  Future<void> get() async {
    final result = await repository.nearestDate();
    state = state.init(result);
  }
}

final getNearestDateEvent = FutureProvider.autoDispose((ref) async {
  await ref.watch(eventNearestDateNotifier.notifier).get();
  return true;
});
