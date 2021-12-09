import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/user/user_model.dart';
import '../../../data/model/user/user_register_model.dart';
import '../../../domain/repository/user_repository.dart';
import '../../../utils/enum_state.dart';

part 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier({
    required this.repository,
  }) : super(const UserState());

  final UserRepository repository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.setState(RequestState.loading);
    final result = await repository.login(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        state = state.setMessage(failure.message);
        state = state.setState(RequestState.error);
      },
      (user) {
        state = state.init(user);
        state = state.setState(RequestState.loaded);
      },
    );
  }

  Future<void> register(UserRegisterModel user) async {
    state = state.setState(RequestState.loading);
    final result = await repository.register(user: user);

    result.fold(
      (failure) {
        state = state.setMessage(failure.message);
        state = state.setState(RequestState.error);
      },
      (user) {
        state = state.init(user);
        state = state.setState(RequestState.loaded);
      },
    );
  }
}
