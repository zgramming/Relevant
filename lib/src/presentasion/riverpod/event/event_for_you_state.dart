part of 'event_for_you_notifier.dart';

class EventForYouState extends Equatable {
  const EventForYouState({
    this.items = const [],
  });

  final List<EventForYouModel> items;
  EventForYouState init(List<EventForYouModel> values) => copyWith(items: [...values]);

  EventForYouState copyWith({
    List<EventForYouModel>? items,
  }) {
    return EventForYouState(
      items: items ?? this.items,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [items];
}
