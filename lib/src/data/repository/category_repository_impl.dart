import 'dart:io';

import '../../domain/repository/category_repository.dart';
import '../../utils/utils.dart';
import '../datasource/category_remote_datasource.dart';
import '../model/category/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required this.remoteDataSource,
  });
  final CategoryRemoteDataSource remoteDataSource;
  @override
  Future<List<Category>> get() async {
    try {
      final result = await remoteDataSource.get();
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }
}
