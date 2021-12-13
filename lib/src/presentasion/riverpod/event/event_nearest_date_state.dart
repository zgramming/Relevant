part of 'event_nearest_date_notifier.dart';

class EventNearestDateState extends Equatable {
  const EventNearestDateState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });
  final List<EventNearestDateModel> items;
  final String message;
  final RequestState state;
  final ActionType actionType;

  EventNearestDateState init(List<EventNearestDateModel> values) => copyWith(
        items: [...values],
      );
  EventNearestDateState onLoadingState(ActionType actionType) => copyWith(
        state: RequestState.loading,
        actionType: actionType,
      );
  EventNearestDateState onErrorState(String message) => copyWith(
        state: RequestState.error,
        message: message,
      );

  EventNearestDateState copyWith({
    List<EventNearestDateModel>? items,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return EventNearestDateState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
      actionType: actionType ?? this.actionType,
    );
  }

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [items, message, state, actionType];
}
