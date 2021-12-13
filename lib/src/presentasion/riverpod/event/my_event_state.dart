part of 'my_event_notifier.dart';

class MyEventState extends Equatable {
  const MyEventState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final List<MyEventModel> items;
  final String message;
  final RequestState state;
  final ActionType actionType;

  MyEventState init(List<MyEventModel> values) => copyWith(items: [...values]);
  MyEventState onLoadingState(ActionType actionType) => copyWith(
        state: RequestState.loading,
        actionType: actionType,
      );
  MyEventState onErrorState(String message) => copyWith(
        state: RequestState.error,
        message: message,
      );

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [items, message, state, actionType];

  MyEventState copyWith({
    List<MyEventModel>? items,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return MyEventState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
      actionType: actionType ?? this.actionType,
    );
  }
}
