import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
  Future<Either<Failure, List<Category>>> get() async {
    try {
      final result = await remoteDataSource.get();
      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> get();
}

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier({
    required this.repository,
  }) : super(const CategoryState());

  final CategoryRepository repository;
  Future<void> get() async {
    state = state.setState(RequestState.loading);
    final result = await repository.get();

    result.fold(
      (failure) {
        state = state.setMessage(failure.message);
        state = state.setState(RequestState.error);
      },
      (values) {
        state = state.init(values);
        state = state.setState(RequestState.loaded);
      },
    );
  }
}

class CategoryState extends Equatable {
  const CategoryState({
    this.items = const [],
    this.message = '',
    this.state = RequestState.empty,
  });
  final List<Category> items;
  final String message;
  final RequestState state;

  CategoryState init(List<Category> values) => copyWith(items: [...values]);
  CategoryState setMessage(String message) => copyWith(message: message);
  CategoryState setState(RequestState state) => copyWith(state: state);

  CategoryState copyWith({
    List<Category>? items,
    String? message,
    RequestState? state,
  }) {
    return CategoryState(
      items: items ?? this.items,
      message: message ?? this.message,
      state: state ?? this.state,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [items, message, state];
}
