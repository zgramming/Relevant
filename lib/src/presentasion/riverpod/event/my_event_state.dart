part of 'my_event_notifier.dart';

class MyEventState extends Equatable {
  const MyEventState({
    this.items = const [],
  });

  final List<MyEventModel> items;

  MyEventState init(List<MyEventModel> values) => copyWith(items: [...values]);

  @override
  bool get stringify => true;
  @override
  List<Object> get props => [items];

  MyEventState copyWith({
    List<MyEventModel>? items,
  }) {
    return MyEventState(
      items: items ?? this.items,
    );
  }
}
