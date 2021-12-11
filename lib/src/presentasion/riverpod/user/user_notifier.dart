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

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.setActionState(RequestState.loading);
      final result = await repository.login(
        email: email,
        password: password,
      );
      state = state.init(result);
      state = state.setActionState(RequestState.loaded);
    } catch (e) {
      final failure = e as Failure;
      state = state.setMessage(failure.message);
      state = state.setActionState(RequestState.error);
    }
  }

  Future<void> register(UserRegisterModel user) async {
    try {
      state = state.setActionState(RequestState.loading);
      final result = await repository.register(user: user);
      state = state.setActionState(RequestState.loaded);
      state = state.init(result);
    } catch (e) {
      state = state.setActionState(RequestState.error);
      if (e is Failure) {
        state = state.setMessage(e.message);
      } else {
        state = state.setMessage(e.toString());
      }
    }
  }
}
