part of 'event_detail_notifier.dart';

class EventDetailState extends Equatable {
  final EventDetailModel item;
  final RequestState onJoinEventState;
  final String message;

  const EventDetailState({
    this.item = const EventDetailModel(),
    this.onJoinEventState = RequestState.empty,
    this.message = '',
  });

  EventDetailState init(EventDetailModel value) => copyWith(item: value);
  EventDetailState setOnJoinEventState(RequestState state) => copyWith(onJoinEventState: state);

  EventDetailState setOnJoinEventSuccess({
    required String message,
    required EventDetailModel value,
  }) =>
      copyWith(
        message: message,
        item: value,
        onJoinEventState: RequestState.loaded,
      );

  EventDetailState setOnJoinEventError(String message) =>
      copyWith(message: message, onJoinEventState: RequestState.error);

  @override
  List<Object> get props => [item, onJoinEventState, message];

  EventDetailState copyWith({
    EventDetailModel? item,
    RequestState? onJoinEventState,
    String? message,
  }) {
    return EventDetailState(
      item: item ?? this.item,
      onJoinEventState: onJoinEventState ?? this.onJoinEventState,
      message: message ?? this.message,
    );
  }
}
