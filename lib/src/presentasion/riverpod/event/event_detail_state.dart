part of 'event_detail_notifier.dart';

class EventDetailState extends Equatable {
  final EventDetailModel item;

  const EventDetailState({
    this.item = const EventDetailModel(),
  });

  EventDetailState init(EventDetailModel value) => copyWith(item: value);

  @override
  List<Object> get props => [item];

  EventDetailState copyWith({
    EventDetailModel? item,
  }) {
    return EventDetailState(
      item: item ?? this.item,
    );
  }
}
