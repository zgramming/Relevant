part of 'event_notifier.dart';

class EventState extends Equatable {
  const EventState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
  });

  final List<Event> items;
  final String message;
  final RequestState state;

  EventState init(List<Event> values) => copyWith(items: [...values]);
  EventState add(Event value) => copyWith(items: [...items, value]);

  EventState setMessage(String message) => copyWith(message: message);
  EventState setState(RequestState state) => copyWith(state: state);

  @override
  List<Object> get props => [items, message, state];

  @override
  String toString() => 'EventState(items: $items, message: $message, state: $state)';

  EventState copyWith({
    List<Event>? items,
    String? message,
    RequestState? state,
  }) {
    return EventState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }
}
