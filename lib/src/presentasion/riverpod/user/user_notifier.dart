import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/user/user_change_password_form_model.dart';
import '../../../data/model/user/user_model.dart';
import '../../../data/model/user/user_register_form_model.dart';
import '../../../data/model/user/user_update_form_model.dart';
import '../../../domain/repository/user_repository.dart';
import '../../../utils/enum_state.dart';
import '../../../utils/failure.dart';

part 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier({
    required this.repository,
  }) : super(const UserState());

  final UserRepository repository;

  Future<void> initializeUser() async {
    final user = await repository.initializeUser();
    state = state.init(user);
  }

  Future<void> logout() async {
    await repository.logout();
    state = state.init(null);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.onLoadingState(ActionType.post);
      final result = await repository.login(
        email: email,
        password: password,
      );
      state = state.onSuccessLogin(result);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorState(failure.message);
    }
  }

  Future<void> register(UserRegisterFormModel model) async {
    try {
      state = state.onLoadingState(ActionType.post);
      final result = await repository.register(model: model);
      state = state.onSuccessRegister(result);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorState(failure.message);
    }
  }

  Future<void> update(UserUpdateFormModel model) async {
    try {
      state = state.onLoadingState(ActionType.post);
      final result = await repository.update(model: model);
      state = state.onSuccessUpdateProfile(result);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorState(failure.message);
    }
  }

  Future<void> changePassword({
    required UserChangePasswordFormModel model,
  }) async {
    try {
      state = state.onLoadingState(ActionType.post);
      final result = await repository.changePassword(model);
      state = state.onSuccessChangePassword(result);
    } catch (e) {
      final failure = e as Failure;
      state = state.onErrorState(failure.message);
    }
  }
}
