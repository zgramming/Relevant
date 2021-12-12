import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_bookmark_model.dart';
import '../../../domain/repository/event_repository.dart';

part 'event_bookmark_state.dart';

class EventBookmarkNotifier extends StateNotifier<EventBookmarkState> {
  EventBookmarkNotifier({
    required this.repository,
  }) : super(const EventBookmarkState());

  final EventRepository repository;

  void initialize() {
    final result = repository.fetchBookmark();
    state = state.init(result);
  }

  Future<String> save(EventBookmarkModel model) async {
    final message = await repository.saveBookmark(model);
    state = state.add(model);
    return message;
  }

  Future<String> delete(int id) async {
    final message = await repository.deleteBookmark(id);
    state = state.delete(id);
    return message;
  }
}

final isAlreadyBookmarked = Provider.autoDispose.family<bool, int>((ref, idEvent) {
  final result = ref
          .watch(eventBookmarkNotifier.select((value) => value.items))
          .firstWhereOrNull((element) => element.id == idEvent) !=
      null;
  return result;
});
