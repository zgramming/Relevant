import 'dart:io';

import '../../domain/repository/user_repository.dart';
import '../../utils/utils.dart';
import '../datasource/user_local_datasource.dart';
import '../datasource/user_remote_datasource.dart';
import '../model/user/user_change_password_form_model.dart';
import '../model/user/user_model.dart';
import '../model/user/user_register_form_model.dart';
import '../model/user/user_update_form_model.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  ///* REMOTE DATASOURCE

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(email: email, password: password);
      await localDataSource.saveSharedPreferences(user);
      return user;
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
    required UserRegisterFormModel model,
  }) async {
    try {
      final user = await remoteDataSource.register(model);
      await localDataSource.saveSharedPreferences(user);
      return user;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<User> update({
    required UserUpdateFormModel model,
  }) async {
    try {
      final result = await remoteDataSource.update(model: model);
      await localDataSource.saveSharedPreferences(result);

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
  Future<User> changePassword(UserChangePasswordFormModel model) async {
    try {
      final result = await remoteDataSource.changePassword(model);
      await localDataSource.saveSharedPreferences(result);
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  ///* LOCAL DATASOURCE
  @override
  Future<User?> initializeUser() async {
    try {
      final result = await localDataSource.fetchSharedPreferences();
      return result;
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final result = await localDataSource.deleteSharedPreferences();
      return result;
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }
}
