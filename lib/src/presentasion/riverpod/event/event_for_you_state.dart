part of 'event_for_you_notifier.dart';

class EventForYouState extends Equatable {
  const EventForYouState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final List<EventForYouModel> items;
  final String message;
  final RequestState state;
  final ActionType actionType;

  EventForYouState init(List<EventForYouModel> values) => copyWith(items: [...values]);
  EventForYouState onLoadingState(ActionType actionType) => copyWith(
        state: RequestState.loading,
        actionType: actionType,
      );
  EventForYouState onErrorState(String message) => copyWith(
        state: RequestState.error,
        message: message,
      );

  EventForYouState copyWith({
    List<EventForYouModel>? items,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return EventForYouState(
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
