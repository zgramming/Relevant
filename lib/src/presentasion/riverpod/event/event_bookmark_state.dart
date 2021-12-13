part of 'event_bookmark_notifier.dart';

class EventBookmarkState extends Equatable {
  const EventBookmarkState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final List<EventBookmarkModel> items;
  final String message;
  final RequestState state;
  final ActionType actionType;

  EventBookmarkState init(List<EventBookmarkModel> values) => copyWith(items: [...values]);
  EventBookmarkState onLoadingState(ActionType actionType) => copyWith(
        state: RequestState.loading,
        actionType: actionType,
      );

  EventBookmarkState onSuccessSave({
    required EventBookmarkModel value,
    required String message,
  }) =>
      copyWith(
        state: RequestState.loaded,
        message: message,
        items: [...items, value],
      );

  EventBookmarkState onSuccessDelete({
    required int idEvent,
    required String message,
  }) =>
      copyWith(
        state: RequestState.loaded,
        message: message,
        items: [...items.where((element) => element.id != idEvent)],
      );

  EventBookmarkState onErrorActionState(String message) => copyWith(
        state: RequestState.error,
        message: message,
      );

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [items, message, state, actionType];

  EventBookmarkState copyWith({
    List<EventBookmarkModel>? items,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return EventBookmarkState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
      actionType: actionType ?? this.actionType,
    );
  }
}
