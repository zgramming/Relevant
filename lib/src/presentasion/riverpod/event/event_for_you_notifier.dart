import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_for_you_model.dart';
import '../../../domain/repository/event_repository.dart';

part 'event_for_you_state.dart';

class EventForYouNotifier extends StateNotifier<EventForYouState> {
  EventForYouNotifier({
    required this.repository,
  }) : super(const EventForYouState());

  final EventRepository repository;

  Future<void> get() async {
    final result = await repository.forYou();
    state = state.init(result);
  }
}

final getEventForYou = FutureProvider.autoDispose((ref) async {
  await ref.watch(eventForYouNotifier.notifier).get();
  return true;
});
