import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/user/user_model.dart';
import '../../../data/model/user/user_register_model.dart';
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
      state = state.setactionLoginState(RequestState.loading);
      final result = await repository.login(
        email: email,
        password: password,
      );
      state = state.init(result);
      state = state.setactionLoginState(RequestState.loaded);
    } catch (e) {
      final failure = e as Failure;
      state = state.setMessage(failure.message);
      state = state.setactionLoginState(RequestState.error);
    }
  }

  Future<void> register(UserRegisterModel model) async {
    try {
      state = state.setactionRegisterState(RequestState.loading);
      final result = await repository.register(model: model);
      state = state.setactionRegisterState(RequestState.loaded);
      state = state.init(result);
    } catch (e) {
      state = state.setactionRegisterState(RequestState.error);
      if (e is Failure) {
        state = state.setMessage(e.message);
      } else {
        state = state.setMessage(e.toString());
      }
    }
  }
}
