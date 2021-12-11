import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:relevant/injection.dart';

import '../../utils/utils.dart';
import '../model/category/category_model.dart';

class CategoryRemoteDataSource {
  Future<List<Category>> get() async {
    final url = Uri.parse("$apiUrl/category");
    final response = await http.get(url);

    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final list = decode['data'] as List;
      final result = list
          .map(
            (e) => Category.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return result;
    } else {
      final message = decode['message'];
      throw Exception(message);
    }
  }
}

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

abstract class CategoryRepository {
  Future<List<Category>> get();
}

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
