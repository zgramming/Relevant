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
      state = state.setActionLoginState(RequestState.loading);
      final result = await repository.login(
        email: email,
        password: password,
      );
      state = state.init(result);
      state = state.setActionLoginState(RequestState.loaded);
    } catch (e) {
      final failure = e as Failure;
      state = state.setMessage(failure.message);
      state = state.setActionLoginState(RequestState.error);
    }
  }

  Future<void> register(UserRegisterFormModel model) async {
    try {
      state = state.setActionRegisterState(RequestState.loading);
      final result = await repository.register(model: model);
      state = state.setActionRegisterState(RequestState.loaded);
      state = state.init(result);
    } catch (e) {
      final failure = e as Failure;
      state = state.setActionRegisterState(RequestState.error);
      state = state.setMessage(failure.message);
    }
  }

  Future<void> update(UserUpdateFormModel model) async {
    try {
      state = state.setActionUpdateState(RequestState.loading);
      final result = await repository.update(model: model);
      state = state.init(result);
      state = state.setActionUpdateState(RequestState.loaded);
    } catch (e) {
      final failure = e as Failure;
      state = state.setActionUpdateState(RequestState.error);
      state = state.setMessage(failure.message);
    }
  }

  Future<void> changePassword({
    required UserChangePasswordFormModel model,
  }) async {
    try {
      state = state.setActionChangePasswordState(RequestState.loading);
      final result = await repository.changePassword(model);
      state = state.init(result);
      state = state.setActionChangePasswordState(RequestState.loaded);
    } catch (e) {
      final failure = e as Failure;
      state = state.setActionChangePasswordState(RequestState.error);
      state = state.setMessage(failure.message);
    }
  }
}
