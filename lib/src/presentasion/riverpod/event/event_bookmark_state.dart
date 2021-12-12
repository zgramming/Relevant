part of 'event_bookmark_notifier.dart';

class EventBookmarkState extends Equatable {
  const EventBookmarkState({
    this.items = const [],
  });
  final List<EventBookmarkModel> items;

  EventBookmarkState init(List<EventBookmarkModel> values) => copyWith(items: [...values]);
  EventBookmarkState add(EventBookmarkModel value) => copyWith(items: [...items, value]);
  EventBookmarkState delete(int id) =>
      copyWith(items: [...items.where((element) => element.id != id).toList()]);

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [items];

  EventBookmarkState copyWith({
    List<EventBookmarkModel>? items,
  }) {
    return EventBookmarkState(
      items: items ?? this.items,
    );
  }
}
