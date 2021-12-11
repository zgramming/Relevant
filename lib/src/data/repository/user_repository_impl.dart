import 'dart:io';

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
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(email: email, password: password);
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<User> register({
    required UserRegisterModel user,
  }) async {
    try {
      final result = await remoteDataSource.register(user);
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }
}
