import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../injection.dart';
import '../../../data/model/category/category_model.dart';
import '../../../domain/repository/category_repository.dart';
import '../../../utils/utils.dart';

part 'category_state.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier({
    required this.repository,
  }) : super(const CategoryState());

  final CategoryRepository repository;

  Future<void> get() async {
    final result = await repository.get();
    state = state.init(result);
  }
}

final futureGetCategory = FutureProvider.autoDispose((ref) async {
  await ref.watch(categoryNotifier.notifier).get();
  return true;
});
