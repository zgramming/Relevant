import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/repository/user_repository.dart';
import '../../utils/failure.dart';
import '../../utils/utils.dart';
import '../datasource/user_remote_datasource.dart';
import '../model/user/user_model.dart';
import '../model/user/user_register_model.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required this.remoteDataSource,
  });

  final UserRemoteDataSource remoteDataSource;
  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(email: email, password: password);
      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi'));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required UserRegisterModel user,
  }) async {
    try {
      final result = await remoteDataSource.register(user);
      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi'));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
