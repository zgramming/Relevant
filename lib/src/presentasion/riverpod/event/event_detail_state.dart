part of 'event_detail_notifier.dart';

class EventDetailState extends Equatable {
  const EventDetailState({
    this.item = const EventDetailModel(),
    this.state = RequestState.empty,
    this.message = '',
    this.actionType = ActionType.empty,
  });

  final EventDetailModel item;
  final RequestState state;
  final String message;
  final ActionType actionType;

  EventDetailState init(EventDetailModel value) => copyWith(item: value);

  EventDetailState onLoadingState(ActionType actionType) => copyWith(
        state: RequestState.loading,
        actionType: actionType,
      );

  EventDetailState onSuccessJoinEvent({
    required String message,
    required EventDetailModel value,
  }) =>
      copyWith(
        message: message,
        item: value,
        state: RequestState.loaded,
      );

  EventDetailState onErrorJoinEvent(String message) => copyWith(
        message: message,
        state: RequestState.error,
      );

  @override
  List<Object> get props => [item, state, message, actionType];

  EventDetailState copyWith({
    EventDetailModel? item,
    RequestState? state,
    String? message,
    ActionType? actionType,
  }) {
    return EventDetailState(
      item: item ?? this.item,
      state: state ?? this.state,
      message: message ?? this.message,
      actionType: actionType ?? this.actionType,
    );
  }
}
