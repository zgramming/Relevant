import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/event_bookmark_model.dart';
import '../../../domain/repository/event_repository.dart';
import '../../../utils/utils.dart';

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

  Future<void> save(EventBookmarkModel model) async {
    try {
      state = state.onLoadingState(ActionType.create);
      final result = await repository.saveBookmark(model);
      state = state.onSuccessSave(value: model, message: result);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorActionState(failure.message);
    }
  }

  Future<void> delete(int id) async {
    try {
      state = state.onLoadingState(ActionType.delete);
      final message = await repository.deleteBookmark(id);
      state = state.onSuccessDelete(idEvent: id, message: message);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorActionState(failure.message);
    }
  }
}

final isAlreadyBookmarked = Provider.autoDispose.family<bool, int>((ref, idEvent) {
  final result = ref
          .watch(eventBookmarkNotifier.select((value) => value.items))
          .firstWhereOrNull((element) => element.id == idEvent) !=
      null;
  return result;
});

final eventBookmarkList = Provider.autoDispose((ref) {
  final idUser = ref.watch(userNotifier.select((value) => value.item?.id ?? 0));
  final result = ref
      .watch(eventBookmarkNotifier.select((value) => value.items))
      .where((element) => element.idUser == idUser)
      .toList();
  return result;
});
