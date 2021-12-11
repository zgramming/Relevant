part of 'event_notifier.dart';

class EventState extends Equatable {
  const EventState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionState = RequestState.empty,
  });

  final List<Event> items;
  final String message;
  final RequestState state;
  final RequestState actionState;

  EventState init(List<Event> values) => copyWith(items: [...values]);
  EventState add(Event value) => copyWith(items: [...items, value]);

  EventState setMessage(String message) => copyWith(message: message);
  EventState setState(RequestState state) => copyWith(state: state);
  EventState setActionState(RequestState state) => copyWith(actionState: state);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [items, message, state, actionState];

  EventState copyWith({
    List<Event>? items,
    String? message,
    RequestState? state,
    RequestState? actionState,
  }) {
    return EventState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
      actionState: actionState ?? this.actionState,
    );
  }
}
