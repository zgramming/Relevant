part of 'event_nearest_date_notifier.dart';

class EventNearestDateState extends Equatable {
  const EventNearestDateState({
    this.items = const [],
  });
  final List<EventNearestDateModel> items;

  EventNearestDateState init(List<EventNearestDateModel> values) => copyWith(
        items: [...values],
      );

  EventNearestDateState copyWith({
    List<EventNearestDateModel>? items,
  }) {
    return EventNearestDateState(
      items: items ?? this.items,
    );
  }

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [items];
}
