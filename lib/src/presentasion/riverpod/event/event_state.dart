part of 'event_notifier.dart';

class EventState extends Equatable {
  const EventState({
    this.item = const Event(),
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final Event item;
  final String message;
  final RequestState state;
  final ActionType actionType;

  EventState onLoadingState(ActionType actionType) => copyWith(
        state: RequestState.loading,
        actionType: actionType,
      );
  EventState onErrorState(String message) => copyWith(
        state: RequestState.error,
        message: message,
      );
  EventState onSuccessCreateEvent(Event event) => copyWith(
        state: RequestState.loaded,
        item: event,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [item, message, state, actionType];

  EventState copyWith({
    Event? item,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return EventState(
      item: item ?? this.item,
      message: message ?? this.message,
      state: state ?? this.state,
      actionType: actionType ?? this.actionType,
    );
  }
}
