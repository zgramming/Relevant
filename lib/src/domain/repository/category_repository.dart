import '../../data/model/category/category_model.dart';

abstract class CategoryRepository {
  Future<List<Category>> get();
}
