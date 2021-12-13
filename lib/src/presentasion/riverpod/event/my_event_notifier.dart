import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/event/my_event_model.dart';
import '../../../data/model/event/query_filter/my_event_query_model.dart';
import '../../../domain/repository/event_repository.dart';

part 'my_event_state.dart';

class MyEventNotifier extends StateNotifier<MyEventState> {
  MyEventNotifier({
    required this.repository,
  }) : super(const MyEventState());
  final EventRepository repository;
  Future<void> get({
    required int idUser,
    required int year,
    required int month,
  }) async {
    final result = await repository.myEvent(
      idUser: idUser,
      year: year,
      month: month,
    );
    state = state.init(result);
  }
}

final myEventQuery = StateProvider<MyEventQueryModel>(
  (ref) => MyEventQueryModel(dateTime: DateTime.now()),
);

final myEventByDay = Provider.autoDispose.family<List<MyEventModel>, DateTime>((ref, date) {
  final myEvent = ref.watch(myEventNotifier.select((value) => value.items));

  final tempMap = <DateTime, List<MyEventModel>>{};

  for (final event in myEvent) {
    final date = DateTime(event.startDate.year, event.startDate.month, event.startDate.day);
    final isExists = tempMap[date];
    if (isExists == null) {
      tempMap[date] = [event];
    } else {
      tempMap[date] = [...isExists, event];
    }
  }

  return tempMap[DateTime(date.year, date.month, date.day)] ?? [];
});

final getMyEvent = FutureProvider.autoDispose((ref) async {
  final idUser = ref.watch(userNotifier.select((value) => value.item?.id));
  final query = ref.watch(myEventQuery);

  await ref.watch(myEventNotifier.notifier).get(
        idUser: idUser ?? 0,
        year: query.dateTime.year,
        month: query.dateTime.month,
      );
  return true;
});
