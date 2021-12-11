part of 'category_notifier.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.items = const [],
  });
  final List<Category> items;

  CategoryState init(List<Category> values) => copyWith(items: [...values]);

  CategoryState copyWith({
    List<Category>? items,
  }) {
    return CategoryState(
      items: items ?? this.items,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [items];
}
