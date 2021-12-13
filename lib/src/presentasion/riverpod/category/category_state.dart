part of 'category_notifier.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
    this.actionType = ActionType.empty,
  });

  final List<Category> items;
  final String message;
  final RequestState state;
  final ActionType actionType;

  CategoryState init(List<Category> values) => copyWith(items: [...values]);

  CategoryState copyWith({
    List<Category>? items,
    String? message,
    RequestState? state,
    ActionType? actionType,
  }) {
    return CategoryState(
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
